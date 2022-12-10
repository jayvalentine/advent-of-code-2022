def part1(input)
    instructions = input.split("\n").map { |s| Processor::Instruction::parse(s) }

    
end

AoC::example(day: 10, part: 1, expected: 13140) do |input|
    part1(input)
end
