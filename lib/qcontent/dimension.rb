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
        self.width, self.height = (first.is_a?(String) ? first.split('x') : first)
        self.height ||= args.shift
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