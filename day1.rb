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

example_foods = get_food_carried(File.read("data/day1/example.txt").split("\n"))
puts "Example 1: #{example_foods.map(&:sum).max}"

puzzle_foods = get_food_carried(File.read("data/day1/puzzle.txt").split("\n"))
puts "Puzzle 1: #{puzzle_foods.map(&:sum).max}"

example_top_three = example_foods.map(&:sum).sort.last(3)
puts "Example 2: #{example_top_three.sum}"

puzzle_top_three = puzzle_foods.map(&:sum).sort.last(3)
puts "Puzzle 2: #{puzzle_top_three.sum}"
