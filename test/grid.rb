require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/grid'

class GridTest < Test::Unit::TestCase
    def test_parse()
        input = "123\n456\n789\n147"

        grid = Grid::parse(input)
        assert_equal(3, grid.width)
        assert_equal(4, grid.height)

        assert_equal(1, grid.get(0, 0))
        assert_equal(2, grid.get(1, 0))
        assert_equal(3, grid.get(2, 0))

        assert_equal(4, grid.get(0, 1))
        assert_equal(5, grid.get(1, 1))
        assert_equal(6, grid.get(2, 1))

        assert_equal(7, grid.get(0, 2))
        assert_equal(8, grid.get(1, 2))
        assert_equal(9, grid.get(2, 2))

        assert_equal(1, grid.get(0, 3))
        assert_equal(4, grid.get(1, 3))
        assert_equal(7, grid.get(2, 3))
    end
end
