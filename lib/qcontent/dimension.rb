module Qcontent
  class Dimension
    class InvalidDimension < ::RuntimeError; end;

    attr_accessor :width, :height

    def initialize(*args)
      first = args.shift
      case first
      when Array
        self.width, self.height = first
      when Hash
        self.width  = first['width'] || first[:width]
        self.height = first['height'] || first[:height]
      when Dimension
        return first
      else
        second = args.shift
        self.width, self.height = first, second
      end
    end

    def width=(w)
      @width = w.nil? ? nil : w.to_i
    end
    
    def height=(h)
      @height = h.nil? ? nil : h.to_i
    end
    
    def to_s(join = 'x')
      "#{width}x#{height}"
    end

    def to_a
      [width, height]
    end

  end
end