module Crane
    # Given a single level of a group of stacks,
    # returns an array representing the element at each level
    # for each stack, where stacks without an element are represented
    # by nil.
    def self.parse_stack_level(s, max_width)
        # Pad input string out to the correct width.
        s += " " * ((max_width*4) - s.size)

        stack_level = Array.new(max_width)
        max_width.times do |i|
            # Get the entry in the level corresponding to this
            # entry, if it exists.
            entry = s[(i * 4)...((i+1) * 4)]

            # Entry must either be in [X] format or be all-spaces.
            if /\[(\w)\]/ =~ entry
                stack_level[i] = $1
            elsif entry.strip.size != 0
                raise "Invalid stack entry: '#{entry}'"
            end
        end

        stack_level
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
