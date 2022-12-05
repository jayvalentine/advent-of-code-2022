require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/crane'

class CraneStackTest < Test::Unit::TestCase
    def test_all_have_elements
        s = Crane::parse_stack_level("[A] [M] [F]", 3)
        assert_equal(3, s.size)
        assert_equal("A", s[0])
        assert_equal("M", s[1])
        assert_equal("F", s[2])
    end

    def test_first_empty
        s = Crane::parse_stack_level("    [F] [T]", 3)
        assert_equal(3, s.size)
        assert_equal(nil, s[0])
        assert_equal("F", s[1])
        assert_equal("T", s[2])
    end

    def test_last_empty
        s = Crane::parse_stack_level("[X] [F]", 3)
        assert_equal(3, s.size)
        assert_equal("X", s[0])
        assert_equal("F", s[1])
        assert_equal(nil, s[2])
    end
end

class CraneInstructionTest < Test::Unit::TestCase
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
