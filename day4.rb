require_relative 'lib/aoc'

def parse_range(s)
    parts = s.split('-')
    start = parts[0].to_i
    finish = parts[1].to_i

    start..finish
end

def get_ranges(input)
    input.split("\n").map do |s|
        s.split(',').map { |s| parse_range(s) }
    end
end

def part1(input)
    ranges = get_ranges(input)

    ranges.count { |pair| pair[0].cover?(pair[1]) || pair[1].cover?(pair[0]) }
end

def ranges_overlap(r1, r2)
    r1.cover?(r2.begin) || r1.cover?(r2.end) || r2.cover?(r1.begin) || r2.cover?(r1.end)
end

def part2(input)
    ranges = get_ranges(input)

    ranges.count { |pair| ranges_overlap(pair[0], pair[1]) }
end

AoC::example(day: 4, part: 1, expected: 2) do |input|
    part1(input)
end

AoC::solution(day: 4, part: 1) do |input|
    part1(input)
end

AoC::example(day: 4, part: 2, expected: 4) do |input|
    part2(input)
end

AoC::solution(day: 4, part: 2) do |input|
    part2(input)
end
