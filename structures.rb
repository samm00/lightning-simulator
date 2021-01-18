class Point
    attr_reader :x_p, :y_p
    attr_accessor :x, :y
  
    def initialize(x_p = 0, y_p = 0)
        @x = x_p
        @y = y_p
    end

    def add(pnt)
        return Point.new(@x + pnt.x, @y + pnt.y)
    end

    def subtract(pnt)
        return Point.new(@x - pnt.x, @y - pnt.y)
    end

    def dot(pnt)
        return Math.sqrt(@x * pnt.x + @y * pnt.y)
    end

    def mult(factor)
        return Point.new(@x * factor, @y * factor)
    end
end

class Segment
    attr_reader :pnt1, :pnt2
    attr_accessor :p1, :p2

    def initialize(pnt1 = Point.new, pnt2 = Point.new)
        @p1 = pnt1
        @p2 = pnt2
    end
end