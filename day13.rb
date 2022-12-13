require 'pp'

require_relative 'lib/aoc'

def get_packet_pairs(input)
    input.split("\n\n").map { |pair| pair.split.map { |packet| eval(packet) } }
end

# Returns true if left is before right, false if they are in wrong order,
# and nil if order is independent.
def packets_in_order?(left, right, depth=0)
    #padding = "    " * depth
    #puts "#{padding}Compare #{left.inspect} vs #{right.inspect}"

    if left.is_a?(Integer) && right.is_a?(Integer)
        if left < right
            true
        elsif left > right
            false
        else
            nil
        end
    elsif left.is_a?(Array) && right.is_a?(Array)
        left.each_with_index do |v, i|
            # If there is no corresponding element on the right side
            # to compare against, the elements are not in the right order.
            if right[i].nil?
                return false
            end

            # If the elements of the two lists at this location are
            # in order, the packet is in order.
            comparison = packets_in_order?(left[i], right[i], depth+1)
            unless comparison.nil?
                return comparison
            end
        end

        if left.size < right.size
            return true
        end

        # If we get to this point then we have compared all elements
        # of the arrays and found none that give us an indication of order.
        return nil

    elsif left.is_a?(Integer) && right.is_a?(Array)
        packets_in_order?([left], right, depth+1)
    elsif left.is_a?(Array) && right.is_a?(Integer)
        packets_in_order?(left, [right], depth+1)
    else
        raise "Invalid types for left (#{left}, #{left.class}) or right (#{right}, #{right.class})"
    end
end

def part1(input)
    packet_pairs = get_packet_pairs(input)
    indices_in_order = []
    packet_pairs.each_with_index do |pair, index|
        left = pair[0]
        right = pair[1]
        if packets_in_order?(left, right)
            indices_in_order << index + 1
        end
    end

    indices_in_order.sum
end


AoC::example(day: 13, part: 1, expected: 13) do |input|
    part1(input)
end

AoC::solution(day: 13, part: 1) do |input|
    part1(input)
end
