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


AoC::example(day: 13, part: 1, expected: 13) do |input|
    part1(input)
end

AoC::solution(day: 13, part: 1) do |input|
    part1(input)
end
