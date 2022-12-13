require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/list_packet'

class ListPacketTest < Test::Unit::TestCase
    def test_less_than_arrays_equal_size
        l = ListPacket.new([1,1,3,1,1])
        r = ListPacket.new([1,1,5,1,1])

        assert_equal(-1, l <=> r)
    end

    def test_integers
        l = ListPacket.new(4)
        r = ListPacket.new(6)

        assert_equal(-1, l <=> r)

        l = ListPacket.new(5)
        r = ListPacket.new(5)

        assert_equal(0, l <=> r)

        l = ListPacket.new(9)
        r = ListPacket.new(3)

        assert_equal(1, l <=> r)
    end

    def test_mixed_greater_than
        l = ListPacket.new([9])
        r = ListPacket.new([[8,7,6]])

        assert_equal(1, l <=> r)
    end

    def test_mixed_equal
        l = ListPacket.new([[4,4],4,4,4])
        r = ListPacket.new([[4,4],4,4,4])

        assert_equal(0, l <=> r)
    end

    def test_left_ran_out
        l = ListPacket.new([[4,4],4,4])
        r = ListPacket.new([[4,4],4,4,4])

        assert_equal(-1, l <=> r)
    end

    def test_right_ran_out
        l = ListPacket.new([7,7,7,7])
        r = ListPacket.new([7,7,7])

        assert_equal(1, l <=> r)
    end

    def test_left_empty
        l = ListPacket.new([])
        r = ListPacket.new([3])

        assert_equal(-1, l <=> r)
    end

    def test_right_empty
        l = ListPacket.new([9])
        r = ListPacket.new([])

        assert_equal(1, l <=> r)
    end

    def test_nested_empty
        l = ListPacket.new([[[]]])
        r = ListPacket.new([[]])

        assert_equal(1, l <=> r)
    end

    def test_big
        l = ListPacket.new([1,[2,[3,[4,[5,6,7]]]],8,9])
        r = ListPacket.new([1,[2,[3,[4,[5,6,0]]]],8,9])

        assert_equal(1, l <=> r)
    end
end
