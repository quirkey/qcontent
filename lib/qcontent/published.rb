module Qcontent
  module Published

    def self.included(klass)
      klass.module_eval do
        def self.active_conditions
          {}
        end

        def self.only_active(&block)
          with_scope({:find => {:conditions => active_conditions}}, &block)
        end
        
        named_scope :active_only, lambda { {:conditions => active_conditions } }  
        
      end
      return unless klass.column_names.include?('published_at')
      klass.module_eval do

        named_scope :published, :conditions => lambda {  ["? > published_at", Time.now.utc]  }
        named_scope :recent, lambda {|how_many| {:order => 'published_at DESC', :limit => how_many || 3 }}

        def published?
          published_at && Time.now.utc > published_at
        end
        alias_method :is_published?, :published?
        alias_method :is_published, :published?

        def self.published_only
          self.with_scope(:find => {:conditions => ["? > published_at", Time.now.utc]}) do
            yield if block_given?
          end
        end

        def self.most_recent(how_many = 1)
          published.find(:all,:order => 'published_at DESC', :limit => how_many) 
          (!all.empty? && how_many == 1) ? all.first : all
        end
        
        def self.active_conditions
          ["published_at <= ?", Time.now.utc]
        end

      end
    end

  end
end