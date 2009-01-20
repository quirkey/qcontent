module Qcontent
  module Assets

    def self.included(klass)
      klass.extend Qcontent::Assets::Macros
    end
    
    module Macros
      
      def has_assets(group_name, options = {})
        
        has_many :content_assets, :as => :content
        has_many "content_#{group_name}", :class_name => 'ContentAsset', 
                                          :order => 'content_assets.position ASC', 
                                          :dependent => :delete_all, 
                                          :as => :content,
                                          :conditions => "content_assets.asset_group = '#{group_name}'"
        has_many group_name, :through => "content_#{group_name}", :source => :asset
        include InstanceMethods
        
        alias_method "#{group_name}_association=", "#{group_name}="
        
        after_save :save_assets
        
        self.class_eval <<-EOT
          def #{group_name}=(hash_of_assets)
            return unless hash_of_assets
            if hash_of_assets.is_a?(Array) && hash_of_assets.first.is_a?(Asset)
              self.#{group_name}_association = hash_of_assets
            else
              collect_assets_to_save(:#{group_name}, hash_of_assets)
            end
          end
          
          def #{group_name.to_s.singularize}
            self.#{group_name}.first
          end
        EOT
      end
      
    end
    
    module InstanceMethods
      
      def collect_assets_to_save(group, hash_of_assets)
        return unless hash_of_assets
        @assets_to_save ||= {}
        @assets_to_save[group.to_s] = hash_of_assets
      end
      
      def save_assets
        logger.debug '== Saving Assets'
        return unless @assets_to_save
        @assets_to_save.each do |group_name, asset_group|
          logger.debug '--- Deleting the whole group'
          self.send("content_#{group_name}").delete_all
          logger.debug "--- Saving Asset group #{group_name} on #{self}"
          asset_group.each do |position, asset_attributes|
            logger.debug "---- #{position}: #{asset_attributes.inspect}"
            if asset_attributes.is_a?(Hash)
              asset = Asset.create({:dir => group_name.to_s}.merge(asset_attributes))
              self.content_assets.create(:asset_id => asset.id, :position => position, :asset_group => group_name.to_s) if asset
            elsif asset_attributes.to_i > 0
              self.content_assets.create(:asset_id => asset_attributes.to_i, :position => position, :asset_group => group_name.to_s)
            end
          end
        end
      end
      
    end
    
  end 
end