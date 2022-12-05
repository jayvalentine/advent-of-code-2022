require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/crane'

class CraneTest < Test::Unit::TestCase
    def test_parse_instruction()
        i = Crane::Instruction.parse("move 4 from 2 to 1")
        assert_equal(4, i.num)
        assert_equal(2, i.from)
        assert_equal(1, i.to)
    end

    def test_parse_instruction_bignums()
        i = Crane::Instruction.parse("move 99 from 42 to 11")
        assert_equal(99, i.num)
        assert_equal(42, i.from)
        assert_equal(11, i.to)
    end
end
