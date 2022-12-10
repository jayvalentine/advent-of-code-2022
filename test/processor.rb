require 'test/unit'
require 'test/unit/assertions'

require_relative '../lib/processor'

class InstructionTest < Test::Unit::TestCase
    def test_parse_addx
        i = Processor::Instruction::parse("addx 10")
        assert_equal(Processor::Instruction::ADDX, i.opcode)
        assert_equal(1, i.operands.size)
        assert_equal(10, i.operands[0])
    end

    def test_parse_noop
        i = Processor::Instruction::parse("noop")
        assert_equal(Processor::Instruction::NOOP, i.opcode)
        assert_equal(0, i.operands.size)
    end
end

class ProcessorTest < Test::Unit::TestCase
    def test_addx
        i = Processor::Instruction.new(Processor::Instruction::ADDX, [5])
        p = Processor.new()
        cycles = p.execute(i)

        assert_equal(2, cycles)
        assert_equal(6, p.x)
    end

    def test_noop
        i = Processor::Instruction.new(Processor::Instruction::NOOP, [])
        p = Processor.new()
        cycles = p.execute(i)

        assert_equal(1, cycles)
        assert_equal(1, p.x)
    end
end
