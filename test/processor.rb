require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/processor'

class InstructionTest < Test::Unit::TestCase
    def test_parse_addx
        i = Processor::Instruction::parse("addx 10")
        assert_equal(Processor::Instruction::ADDX, i.opcode)
        assert_equal(2, i.cycles)
        assert_equal(1, i.operands.size)
        assert_equal(10, i.operands[0])
    end

    def test_parse_noop
        i = Processor::Instruction::parse("noop")
        assert_equal(1, i.cycles)
        assert_equal(Processor::Instruction::NOOP, i.opcode)
        assert_equal(0, i.operands.size)
    end
end

class ProcessorTest < Test::Unit::TestCase
    def test_addx
        i = Processor::Instruction.new(Processor::Instruction::ADDX, 2, [5])
        p = Processor.new([i])

        assert_equal(true, p.instructions?)

        assert_equal(1, p.x)

        p.cycle()

        assert_equal(1, p.x)
        assert_equal(true, p.instructions?)

        p.cycle()
        
        assert_equal(6, p.x)
        assert_equal(false, p.instructions?)
    end

    def test_noop
        i = Processor::Instruction.new(Processor::Instruction::NOOP, 1, [])
        p = Processor.new([i])
        
        assert_equal(true, p.instructions?)

        p.cycle()

        assert_equal(1, p.x)
        assert_equal(false, p.instructions?)
    end
end
