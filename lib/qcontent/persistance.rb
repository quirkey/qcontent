# Persist an AR object in a session
module Qcontent
  module Persistance
    
    def self.included(klass)
      klass.extend Qcontent::Persistance::Macros
    end

    module Macros
      def persist(name, options = {})
        name        = name.to_s
        session_var   = options[:in]   || name.foreign_key
        klass         = options[:type] || name.classify
        allow_symbols = options[:allow_symbols] || false

        to_eval = <<-EOT
        helper_method :#{name}

        protected
        def #{name}
        EOT
        if allow_symbols
          to_eval << "@_#{name} ||= (session[:#{session_var}] ? (session[:#{session_var}].is_a?(Symbol) ? session[:#{session_var}] : #{klass}.find(session[:#{session_var}])) : nil)"
        else
          to_eval << "@_#{name} ||= (session[:#{session_var}] ? #{klass}.find(session[:#{session_var}]) : nil)"
        end
        to_eval << <<-EOT
        end
      
        def #{name}=(set_object)
          @_#{name} = nil
        EOT
        
        if allow_symbols
          to_eval << <<-EOT
          session[:#{session_var}] = if set_object.is_a?(#{klass})
            set_object.id
          elsif set_object.is_a?(Symbol)
            set_object
          else
            nil
          end
          EOT
        else
          to_eval << "session[:#{session_var}] = (set_object.is_a?(#{klass}) ? set_object.id : nil)"
        end
        
        to_eval << <<-EOT
        end
        
        def clear_#{name}!
          @_#{name} = nil
          session.delete(:#{session_var})
        end
        EOT
        module_eval to_eval
      end
    end

  end
end


