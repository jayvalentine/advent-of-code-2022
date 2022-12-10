require_relative 'lib/aoc'
require_relative 'lib/grid'

def part1(input)
    # Parse the input grid.
    grid = Grid::parse(input)
end

AoC::example(day: 8, part: 1, expected: 21) do |input|
    part1(input)
end
