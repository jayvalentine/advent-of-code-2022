require_relative 'lib/aoc'
require_relative 'lib/crane'

def get_message(stacks)
    s = ""
    stacks.each do |stack|
        s += stack[-1] unless stack[-1].nil?
    end

    s
end

def parse_stacks_and_instructions(input)
    input = input.split("\n")

    # Get the elements on each stack.
    stack_level_strings = []
    while (/\[\w\]/ =~ (s = input.shift))
        stack_level_strings << s
    end

    # Now parse the number of stacks.
    # Here we are assuming they are numbered in ascending order.
    num_stacks = s.split.map(&:to_i).max

    # Instantiate the stacks.
    stacks = []
    num_stacks.times do |i|
        stacks[i] = []
    end

    stack_level_strings.each do |s|
        stack_level = Crane::parse_stack_level(s, num_stacks)
        num_stacks.times do |i|
            stacks[i].unshift(stack_level[i]) unless stack_level[i].nil?
        end
    end

    # Now skip the extra blank line.
    input.shift

    # Now parse all the instructions
    instructions = input.map { |s| Crane::Instruction.parse(s) }

    [stacks, instructions]
end

def part1(input)
    stacks, instructions = parse_stacks_and_instructions(input)

    # Now perform the instructions on the stacks.
    instructions.each do |i|
        i.num.times do
            # Move the items - remember the index offset!
            e = stacks[i.from - 1].pop
            stacks[i.to - 1].push(e)
        end
    end

    # Now return the string given by the top of each stack.
    get_message(stacks)
end

def part2(input)
end

AoC::example(day: 5, part: 1, expected: "CMZ") do |input|
    part1(input)
end

AoC::solution(day: 5, part: 1) do |input|
    part1(input)
end

AoC::example(day: 5, part: 2, expected: "MCD") do |input|
    part2(input)
end
