class Processor
    class Instruction
        ADDX = "addx"
        NOOP = "noop"

        OPCODE_MAPPINGS = {
            "addx" => [ADDX, 2],
            "noop" => [NOOP, 1]
        }

        attr_reader :opcode, :cycles, :operands

        def initialize(opcode, cycles, operands)
            @opcode = opcode
            @cycles = cycles
            @operands = operands
        end

        def to_s
            "#{opcode} #{operands.join(", ")}"
        end

        def self.parse(s)
            opcode_s, *operands = s.split

            raise "Invalid opcode '#{opcode_s}'" if OPCODE_MAPPINGS[opcode_s].nil?
            opcode = OPCODE_MAPPINGS[opcode_s][0]
            cycles = OPCODE_MAPPINGS[opcode_s][1]

            operands = operands.map { |o| o.to_i }

            self.new(opcode, cycles, operands)
        end
    end

    attr_reader :x

    # Create a processor instance that will execute the given list of instructions.
    def initialize(instructions)
        @instructions = instructions
        @current_instruction_cycles = @instructions.empty? ? 0 : @instructions[0].cycles

        @x = 1
    end

    # Simulate a single cycle of the processor.
    def cycle
        @current_instruction_cycles -= 1
        if @current_instruction_cycles.zero?
            execute(@instructions.shift)
            @current_instruction_cycles = @instructions.empty? ? 0 : @instructions[0].cycles
        end
    end

    # True if the processor has instructions left to execute, false otherwise.
    def instructions?
        !@instructions.empty?
    end

    
    def execute(instruction)
        if instruction.opcode == Instruction::ADDX
            @x += instruction.operands[0]
        end
    end

    private :execute
end