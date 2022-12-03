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

def part2(input)
    all_badges = []

    input.split("\n").each_slice(3) do |group|
        badges = nil
        group.each do |rucksack|
            first, last = rucksack_contents(rucksack)
            if badges.nil?
                badges = first + last
            else
                badges = common_items(badges, first + last)
            end
        end

        all_badges += badges.uniq
    end

    all_badges.map { |b| priority(b) }.sum
end



AoC::example(day: 3, part: 1, expected: 157) do |input|
    part1(input)
end

AoC::solution(day: 3, part: 1) do |input|
    part1(input)
end

AoC::example(day: 3, part: 2, expected: 70) do |input|
    part2(input)
end

AoC::solution(day: 3, part: 2) do |input|
    part2(input)
end
