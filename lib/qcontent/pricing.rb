module Qcontent
  module Pricing

    class << self
      def included(klass)
        klass.extend MacroMethods
      end

      def convert_to_cents(money_like)
        case money_like
        when String
          money_like.gsub!(/[\$,\ ]/, '')
          if money_like =~ /\./
            money_like.gsub(/[\.]/,'').to_i
          else
            money_like.to_i * 100
          end
        when Money
          money_like.cents.to_i
        else
          money_like.to_i
        end          
      end

      def convert_to_money(money_like)
        Money.new(convert_to_cents(money_like))
      end 
    end

    module MacroMethods

      def has_price(price_method, options = {})
        include Qcontent::Pricing::InstanceMethods
        default_value = options[:default] || Money.new(0)
        attribute_name = options[:attribute] || "#{price_method}_cents"
        override = options[:override] || Proc.new { false }
        define_price_methods(price_method, attribute_name, default_value, &override)
      end

      protected

      def define_price_methods(price_name, attribute_name, default_value, &override)
        module_eval do
          define_method(price_name) do
            val = override.call(self)
            return val if val
            read_attribute(attribute_name.to_sym) ? Money.new(read_attribute(attribute_name.to_sym)) : default_value
          end

          define_method("#{price_name}=") do |new_price|
            set_price(new_price, attribute_name.to_sym)
          end

          define_method("#{price_name}?") do
            self.send(price_name) != default_value
          end
        end
      end
    end

    module InstanceMethods

      protected
      def set_price(new_price, attribute)
        write_attribute(attribute, Qcontent::Pricing.convert_to_cents(new_price))
      end

    end

  end
end
