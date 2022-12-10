class Processor
    class Instruction
        ADDX = 1
        NOOP = 2

        OPCODE_MAPPINGS = {
            "addx" => ADDX,
            "noop" => NOOP
        }

        attr_reader :opcode, :operands

        def initialize(opcode, operands)
            @opcode = opcode
            @operands = operands
        end

        def self.parse(s)
            opcode, *operands = s.split

            raise "Invalid opcode '#{opcode}'" if OPCODE_MAPPINGS[opcode].nil?
            opcode = OPCODE_MAPPINGS[opcode]

            operands = operands.map { |o| o.to_i }

            self.new(opcode, operands)
        end
    end

    attr_reader :x

    def initialize
        @x = 1
    end

    def execute(instruction)
        if instruction.opcode == Instruction::ADDX
            @x += instruction.operands[0]
            2
        elsif instruction.opcode == Instruction::NOOP
            1
        end
    end
end