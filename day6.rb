require_relative 'lib/aoc'
require_relative 'lib/message'

class String
    def each_window_with_index(window_size)
        chars().size.times do |i|
            window = self[i...i+window_size]
            yield [window, i]
        end
    end
end

def part1(input)
    message = input.strip
    message.each_window_with_index(4) do |w, i|
        if Message::is_start?(w)
            return i+4 # Account for the size of the message.
        end
    end

    raise "No message start marker found!"
end

AoC::example(day: 6, part: 1, expected: 7) do |input|
    part1(input)
end
