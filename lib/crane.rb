module Crane
    # Given a single level of a group of stacks,
    # returns an array representing the element at each level
    # for each stack, where stacks without an element are represented
    # by nil.
    def parse_stack_level(s)
        []
    end

    # Represents an instruction for the crane.
    class Instruction
        attr_reader :num, :from, :to

        def initialize(num, from, to)
            @num = num
            @from = from
            @to = to
        end

        def self.parse(s)
            # Assume format "move X from Y to Z"
            parts = s.split
            num = parts[1].to_i
            from = parts[3].to_i
            to = parts[5].to_i

            self.new(num, from, to)
        end
    end
end
