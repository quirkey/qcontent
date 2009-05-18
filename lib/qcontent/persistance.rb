# Persist an AR object in a session
module Qcontent
  module Persistance
    
    def self.included(klass)
      klass.extend Qcontent::Persistance::Macros
    end

    module Macros
      def persist(name, options = {})
        name        = name.to_s
        session_var = options[:in]   || name.foreign_key
        klass       = options[:type] || name.classify

        module_eval <<-EOT
        helper_method :#{name}

        protected
        def #{name}
          @_#{name} ||= (session[:#{session_var}] ? #{klass}.find(session[:#{session_var}]) : nil)
        end

        def #{name}=(set_object)
          @_#{name} = nil
          session[:#{session_var}] = (set_object.is_a?(#{klass}) ? set_object.id : nil)
        end

        def clear_#{name}!
          @_#{name} = nil
          session.delete(:#{session_var})
        end
        EOT
      end
    end

  end
end


