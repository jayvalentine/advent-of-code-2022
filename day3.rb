require_relative 'lib/aoc'

def priority(item)
    if ('a'..'z').include? item
        # Subtract position of 'a' in ASCII table, make sure priorities
        # begin at 1.
        return item.ord - 97 + 1
    elsif ('A'..'Z').include? item
        # Subtract position of 'A' in ASCII table, make sure priorities
        # begin at 27.
        return item.ord - 65 + 27
    else
        raise "Invalid item: '#{item}'"
    end
end

def rucksack_contents(items)
    # Convert string to char array.
    items = items.chars
    first = items.first(items.size/2)
    last = items.last(items.size/2)

    [first, last]
end

def common_items(items1, items2)
    items1.select { |i| items2.include? i }
end

def part1(input)
    common = []
    input.split("\n").each do |items|
        first, last = rucksack_contents(items)
        common += common_items(first, last).uniq
    end

    common.map { |i| priority(i) }.sum
end

AoC::example(day: 3, part: 1, expected: 157) do |input|
    part1(input)
end
