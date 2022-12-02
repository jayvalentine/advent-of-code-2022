require_relative 'lib/aoc'

def get_food_carried(entries)
    foods = []
    this_food = []
    entries.each do |e|
        if e.strip.empty?
            foods << this_food
            this_food = []
        else
            this_food << e.to_i
        end
    end

    # Add the last elf's food to the list.
    foods << this_food unless this_food.empty?

    foods
end

AoC::example(day: 1, part: 1, expected: 24000) do |example|
    get_food_carried(example.split("\n")).map(&:sum).max
end

AoC::solution(day: 1, part: 1) do |data|
    get_food_carried(data.split("\n")).map(&:sum).max
end

AoC::example(day: 1, part: 2, expected: 45000) do |example|
    get_food_carried(example.split("\n")).map(&:sum).sort.last(3).sum
end

AoC::solution(day: 1, part: 2) do |data|
    get_food_carried(data.split("\n")).map(&:sum).sort.last(3).sum
end
