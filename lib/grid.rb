class Grid
    def initialize(rows)
        @rows = rows
    end

    def get(x, y)
        @rows[y][x]
    end

    def set(x, y, val)
        @rows[y][x] = val
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
