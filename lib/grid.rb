class Grid
    # Represents an (x, y, z) coordinate on a grid.
    Point = Struct.new("Point", :x, :y, :z) do
        # Override initialize for Point to add a default
        # value for the z dimension.
        def initialize(x, y, z=0)
            super
        end
        
        def +(vector)
            Point.new(x + vector.dx, y + vector.dy, z + vector.dz)
        end

        # Gives the vector to get from the point 'other'
        # to this one.
        def -(other)
            Vector.new(x - other.x, y - other.y, z - other.z)
        end

        def to_s
            "(x: #{x}, y: #{y}, z: #{z})"
        end
    end

    # Represents a vector in 3D space.
    Vector = Struct.new("Vector", :dx, :dy, :dz) do
        def initialize(dx, dy, dz=0)
            super
        end
        
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

    def to_s
        @rows.map(&:join).join("\n")
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

    def each
        each_point do |p|
            yield [p, self[p]]
        end
    end

    def width
        @rows[0].size
    end

    def height
        @rows.size
    end

    # Returns the first point found with the given value,
    # or nil if no such point exists.
    def find(v)
        each do |p, v2|
            if v == v2
                return p
            end
        end

        nil
    end

    # Gets up to four "manhattan" neighbours of the given point.
    def neighbours(p)
        n = []

        # Bottom
        n << (p + Vector::new(0, 1)) unless p.y + 1 >= height

        # Right
        n << (p + Vector::new(1, 0)) unless p.x + 1 >= width

        # Top
        n << (p + Vector::new(0, -1)) unless p.y == 0

        # Left
        n << (p + Vector::new(-1, 0)) unless p.x == 0

        n.map { |p2| [p2, self[p2]] }
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
