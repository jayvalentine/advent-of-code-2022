require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/grid'

class GridTest < Test::Unit::TestCase
    def test_parse()
        input = "123\n456\n789\n147"

        grid = Grid::parse(input)
        assert_equal(3, grid.width)
        assert_equal(4, grid.height)

        assert_equal(1, grid[Grid::Point.new(0, 0)])
        assert_equal(2, grid[Grid::Point.new(1, 0)])
        assert_equal(3, grid[Grid::Point.new(2, 0)])

        assert_equal(4, grid[Grid::Point.new(0, 1)])
        assert_equal(5, grid[Grid::Point.new(1, 1)])
        assert_equal(6, grid[Grid::Point.new(2, 1)])

        assert_equal(7, grid[Grid::Point.new(0, 2)])
        assert_equal(8, grid[Grid::Point.new(1, 2)])
        assert_equal(9, grid[Grid::Point.new(2, 2)])

        assert_equal(1, grid[Grid::Point.new(0, 3)])
        assert_equal(4, grid[Grid::Point.new(1, 3)])
        assert_equal(7, grid[Grid::Point.new(2, 3)])
    end

    def test_exception_on_invalid_point
        grid = Grid.new([[1, 2, 3], [4, 5, 6]])
        assert_equal(3, grid.width)
        assert_equal(2, grid.height)

        assert_raise(KeyError, "Point (3, 2) out of range.") do
            grid[Grid::Point.new(3, 2)]
        end

        assert_raise(KeyError, "Point (-1, 1) out of range.") do
            grid[Grid::Point.new(-1, 1)]
        end

        assert_raise(KeyError, "Point (2, 2) out of range.") do
            grid[Grid::Point.new(2, 2)]
        end

        assert_raise(KeyError, "Point (1, -1) out of range.") do
            grid[Grid::Point.new(1, -1)]
        end
    end

    def test_neighbours
        grid = Grid.new([[9, 8, 7], [6, 5, 4], [3, 2, 1]])

        neighbours = grid.neighbours(Grid::Point.new(0, 0))
        assert_equal(2, neighbours.size)
        assert_equal([Grid::Point.new(0, 1), 6], neighbours[0])
        assert_equal([Grid::Point.new(1, 0), 8], neighbours[1])

        neighbours = grid.neighbours(Grid::Point.new(1, 1))
        assert_equal(4, neighbours.size)
        assert_equal([Grid::Point.new(1, 2), 2], neighbours[0])
        assert_equal([Grid::Point.new(2, 1), 4], neighbours[1])
        assert_equal([Grid::Point.new(1, 0), 8], neighbours[2])
        assert_equal([Grid::Point.new(0, 1), 6], neighbours[3])

        neighbours = grid.neighbours(Grid::Point.new(2, 0))
        assert_equal(2, neighbours.size)
        assert_equal([Grid::Point.new(2, 1), 4], neighbours[0])
        assert_equal([Grid::Point.new(1, 0), 8], neighbours[1])

        neighbours = grid.neighbours(Grid::Point.new(1, 2))
        assert_equal(3, neighbours.size)
        assert_equal([Grid::Point.new(2, 2), 1], neighbours[0])
        assert_equal([Grid::Point.new(1, 1), 5], neighbours[1])
        assert_equal([Grid::Point.new(0, 2), 3], neighbours[2])
    end

    def test_find
        grid = Grid.new([[9, 8, 7], [6, 5, 4], [3, 2, 1]])

        assert_equal(Grid::Point.new(0, 0), grid.find(9))
        assert_equal(Grid::Point.new(1, 1), grid.find(5))
        assert_equal(nil, grid.find(11))
    end

    def test_transform
        grid = Grid.new([[9, 8, 7], [6, 5, 4], [3, 2, 1]])

        grid2 = grid.transform do |p, v|
            if p == Grid::Point.new(1, 2)
                42
            else
                -v
            end
        end

        assert_equal(-9, grid2[Grid::Point.new(0, 0)])
        assert_equal(-8, grid2[Grid::Point.new(1, 0)])
        assert_equal(-7, grid2[Grid::Point.new(2, 0)])

        assert_equal(-6, grid2[Grid::Point.new(0, 1)])
        assert_equal(-5, grid2[Grid::Point.new(1, 1)])
        assert_equal(-4, grid2[Grid::Point.new(2, 1)])

        assert_equal(-3, grid2[Grid::Point.new(0, 2)])
        assert_equal(42, grid2[Grid::Point.new(1, 2)])
        assert_equal(-1, grid2[Grid::Point.new(2, 2)])
    end

    def test_with_custom_init
        grid = Grid::parse("abc\nFoz\n!bc") do |c|
            if c == "F"
                100
            elsif c == "!"
                200
            else
                c.ord
            end
        end

        assert_equal(97, grid[Grid::Point.new(0, 0)])
        assert_equal(98, grid[Grid::Point.new(1, 0)])
        assert_equal(99, grid[Grid::Point.new(2, 0)])

        assert_equal(100, grid[Grid::Point.new(0, 1)])
        assert_equal(111, grid[Grid::Point.new(1, 1)])
        assert_equal(122, grid[Grid::Point.new(2, 1)])

        assert_equal(200, grid[Grid::Point.new(0, 2)])
        assert_equal(98, grid[Grid::Point.new(1, 2)])
        assert_equal(99, grid[Grid::Point.new(2, 2)])
    end

    def test_point_project
        v = Grid::Vector.new(0, 1)
        project = v.project(Grid::Point.new(0, 0), 4)

        assert_equal(4, project.size)
        assert_equal(Grid::Point.new(0, 0), project[0])
        assert_equal(Grid::Point.new(0, 1), project[1])
        assert_equal(Grid::Point.new(0, 2), project[2])
        assert_equal(Grid::Point.new(0, 3), project[3])
    end

    def test_point_project_length_0
        v = Grid::Vector.new(0, 1)
        project = v.project(Grid::Point.new(4, 0), 0)
        assert_equal(0, project.size)
    end

    def test_point_subtract
        p = Grid::Point.new(0, 1)
        p2 = Grid::Point.new(0, 0)

        assert_equal(Grid::Vector.new(0, 1), p - p2)
        assert_equal(Grid::Vector.new(0, -1), p2 - p)

        p = Grid::Point.new(2, 0)
        p2 = Grid::Point.new(1, 0)

        assert_equal(Grid::Vector.new(1, 0), p - p2)
        assert_equal(Grid::Vector.new(-1, 0), p2 - p)

        p = Grid::Point.new(4, 3)
        p2 = Grid::Point.new(5, 2)

        assert_equal(Grid::Vector.new(-1, 1), p - p2)
        assert_equal(Grid::Vector.new(1, -1), p2 - p)
    end
end
