require 'pp'

require_relative 'lib/aoc'
require_relative 'lib/list_packet'

def get_packet_pairs(input)
    input.split("\n\n").map { |pair| pair.split.map { |packet| ListPacket::parse(packet) } }
end

def part1(input)
    packet_pairs = get_packet_pairs(input)
    indices_in_order = []
    packet_pairs.each_with_index do |pair, index|
        left = pair[0]
        right = pair[1]
        if left < right
            indices_in_order << index + 1
        end
    end

    indices_in_order.sum
end

def part2(input)
    packets = get_packet_pairs(input).flatten

    marker1 = ListPacket.new([[2]])
    marker2 = ListPacket.new([[6]])
    
    packets << marker1
    packets << marker2

    packets.sort!

    i1 = packets.index(marker1) + 1
    i2 = packets.index(marker2) + 1
    i1 * i2
end

AoC::example(day: 13, part: 1, expected: 13) do |input|
    part1(input)
end

AoC::solution(day: 13, part: 1) do |input|
    part1(input)
end

AoC::example(day: 13, part: 2, expected: 140) do |input|
    part2(input)
end

AoC::solution(day: 13, part: 2) do |input|
    part2(input)
end
