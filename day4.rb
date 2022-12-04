require_relative 'lib/aoc'

def parse_range(s)
    parts = s.split('-')
    start = parts[0].to_i
    finish = parts[1].to_i

    start..finish
end

def part1(input)
    ranges = input.split("\n").map do |s|
        s.split(',').map { |s| parse_range(s) }
    end

    ranges.count { |pair| pair[0].cover?(pair[1]) || pair[1].cover?(pair[0]) }
end

AoC::example(day: 4, part: 1, expected: 2) do |input|
    part1(input)
end

AoC::solution(day: 4, part: 1) do |input|
    part1(input)
end
