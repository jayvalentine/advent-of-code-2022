class Grid
    # Represents an (x, y) coordinate on a grid.
    Point = Struct.new("Point", :x, :y) do
        def +(vector)
            Point.new(x + vector.dx, y + vector.dy)
        end

        def to_s
            "(#{x}, #{y})"
        end
    end

    # Represents a vector in 2D space.
    Vector = Struct.new("Vector", :dx, :dy) do
        def project(point, n)
            return [] if n == 0

            project = [point]

            (n-1).times do |i|
                project << project[i] + self
            end

            project
        end
    end

    def initialize(rows)
        @rows = rows
    end

    def [](p)
        if p.x < 0 || p.x >= width || p.y < 0 || p.y >= height
            raise KeyError.new("Point (#{p.x}, #{p.y}) out of range.")
        end

        @rows[p.y][p.x]
    end

    def each_point
        height.times do |y|
            width.times do |x|
                yield Point.new(x, y)
            end
        end
    end

    def width
        @rows[0].size
    end

    def height
        @rows.size
    end

    def self.parse(input)
        rows = input.split("\n").map { |r| r.chars.map(&:to_i) }
        Grid.new(rows)
    end
end
