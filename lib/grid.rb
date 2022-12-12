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

    def []=(p, v)
        if p.x < 0 || p.x >= width || p.y < 0 || p.y >= height
            raise KeyError.new("Point (#{p.x}, #{p.y}) out of range.")
        end

        @rows[p.y][p.x] = v
    end

    def points
        arr = []
        each_point do |p|
            arr << p
        end
        arr
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

    # Transforms a grid onto another grid of the same shape
    # using the given block.
    def transform(&block)
        # Blank rows for new grid.
        new_rows = @rows.map { |r| Array.new(r.size) }

        new_grid = Grid.new(new_rows)

        points.each do |p|
            new_value = block.call(p, self[p])
            new_grid[p] = new_value
        end

        new_grid
    end

    def self.parse(input, &block)
        rows = input.split("\n")
        
        # If a block is given, use it to parse the characters
        # in the grid.
        #
        # Otherwise assume the characters are integers by default.
        if block_given?
            rows.map! { |r| r.chars.map { |c| block.call(c) } }
        else
            rows.map! { |r| r.chars.map(&:to_i) }
        end
        Grid.new(rows)
    end
end
