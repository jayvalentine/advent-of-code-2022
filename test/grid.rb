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
end
