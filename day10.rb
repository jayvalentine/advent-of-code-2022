require_relative 'lib/aoc'
require_relative 'lib/processor'

def part1(input)
    instructions = input.split("\n").map { |s| Processor::Instruction::parse(s) }

    processor = Processor.new(instructions)

    cycles = 0

    signal_strengths = []

    # Process each instruction in turn.
    while (processor.instructions?)
        # Increment the number of cycles first.
        # This makes sure we are checking if we are "during"
        # cycle X before actually executing the instruction that finishes
        # during that cycle.
        cycles += 1
        if (cycles - 20) % 40 == 0
            signal_strengths << cycles * processor.x
        end

        processor.cycle()
    end

    signal_strengths.sum
end

def part2(input)
    instructions = input.split("\n").map { |s| Processor::Instruction::parse(s) }

    processor = Processor.new(instructions)

    cycles = 0

    row = ""
    while (processor.instructions?)
        # If current cycles is a multiple of 40, blank row.
        if (cycles % 40 == 0)
            puts "#{row}\n"
            row = ""
        end

        # Draw the current pixel - is it on or off?
        if ((processor.x-1)..(processor.x+1)).include?(row.size)
            row += "#"
        else
            row += "."
        end

        # Increment cycle count.
        cycles += 1

        # Execute processor cycle.
        processor.cycle
    end

    # Print final row.
    puts row
end

AoC::example(day: 10, part: 1, expected: 13140) do |input|
    part1(input)
end

AoC::solution(day: 10, part: 1) do |input|
    part1(input)
end

puts "Day 10, example 2:"
part2(AoC::data(10, "example.txt"))

puts "Day 10, solution 2:"
part2(AoC::data(10, "puzzle.txt"))
