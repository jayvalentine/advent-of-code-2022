class Grid
    # Represents an (x, y) coordinate on a grid.
    Point = Struct.new("Point", :x, :y) do
        def +(vector)
            Point.new(x + vector.dx, y + vector.dy)
        end
    end

    # Represents a vector in 2D space.
    Vector = Struct.new("Vector", :dx, :dy) do
        def project(point, n)
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
        @rows[p.y][p.x]
    end

    def []=(p, val)
        @rows[p.y][p.x] = val
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
