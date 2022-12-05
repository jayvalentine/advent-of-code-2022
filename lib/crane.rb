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
            self.new(0, 0, 0)
        end
    end
end
