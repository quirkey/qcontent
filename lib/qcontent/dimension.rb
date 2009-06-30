module Qcontent
  class Dimension
    class InvalidDimension < ::RuntimeError; end;
    include Comparable
    
    attr_accessor :name, :width, :height

    def initialize(*args)
      parse_arguments(*args)
      @name ||= dimension_s
    end

    def ==(other)
      self.width == other.width && self.height == other.height
    end
    
    def width=(w)
      @width = w.nil? ? nil : w.to_i
    end
    
    def height=(h)
      @height = h.nil? ? nil : h.to_i
    end
    
    def to_s(join = 'x')
      name ? name : dimension_s(join)
    end
    
    def to_a
      [width, height]
    end
    
    def to_args
      [name, width, height]
    end
    
    def dimension_s(join = 'x')
      "#{width}#{join}#{height}"
    end
    
    def inspect
      "<:Dimension: #{name}, #{dimension_s}:>"
    end
  
    private
    def parse_arguments(*args)
      first = args.shift
      case first
      when Array
        parse_arguments(*first)
      when Hash
        self.width  = first['width']  || first[:width]
        self.height = first['height'] || first[:height]
        self.name   = first['name']   || first[:name]
      when Qcontent::Dimension
        parse_arguments(*first.to_args)
      when Fixnum
        self.width  = first
        self.height = args.shift
      when Symbol
        self.name  = first.to_s
        parse_arguments(*args)
      else
        if !first.nil? && first.to_i == 0 # its a name
          self.name = first
          parse_arguments(*args)
        else
          self.width, self.height = (first.is_a?(String) ? first.split('x') : first)
          self.height ||= args.shift
        end
      end
    end
  
  end
end