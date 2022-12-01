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
    foods
end

example_foods = get_food_carried(File.read("data/day1/example1.txt").split("\n"))
puts "Example 1: #{example_foods.map(&:sum).max}"

puzzle1_foods = get_food_carried(File.read("data/day1/puzzle1.txt").split("\n"))
puts "Puzzle 1: #{puzzle1_foods.map(&:sum).max}"
