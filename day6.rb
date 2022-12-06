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

def get_marker(input, width)
    message = input.strip
    message.each_window_with_index(width) do |w, i|
        if Message::is_packet_marker?(w)
            return i+width # Account for the size of the marker.
        end
    end

    raise "No message start marker found!"
end

PACKET_MARKER_WIDTH = 4
MESSAGE_MARKER_WIDTH = 14

AoC::example(day: 6, part: 1, expected: 7) do |input|
    get_marker(input, PACKET_MARKER_WIDTH)
end

AoC::solution(day: 6, part: 1) do |input|
    get_marker(input, PACKET_MARKER_WIDTH)
end

AoC::example(day: 6, part: 2, expected: 19) do |input|
    get_marker(input, MESSAGE_MARKER_WIDTH)
end

AoC::solution(day: 6, part: 2) do |input|
    get_marker(input, MESSAGE_MARKER_WIDTH)
end
