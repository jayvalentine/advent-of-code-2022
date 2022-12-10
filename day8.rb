require_relative 'lib/aoc'
require_relative 'lib/grid'

def get_visible_trees(grid, row, vector)
    visible = []

    row.each do |p|
        # Get the trees in this line of the grid.
        tree_points = vector.project(p, grid.height)

        # Count the number of trees that are visible in this line.
        tallest = -1
        tree_points.each do |t|
            if grid[t] > tallest
                # Record that this point is visible.
                visible << t

                # Record that this is now the tallest tree we've seen.
                tallest = grid[t]
            end
        end
    end

    visible
end

def part1(input)
    # Parse the input grid.
    grid = Grid::parse(input)

    all_visible = []

    # For each edge, get the trees in that edge that are visible.

    # Top.
    vector_t = Grid::Vector.new(0, 1)
    row_t = Grid::Vector.new(1, 0).project(Grid::Point.new(0, 0), grid.width)
    all_visible += get_visible_trees(grid, row_t, vector_t)

    # Left.
    vector_l = Grid::Vector.new(1, 0)
    row_l = Grid::Vector.new(0, 1).project(Grid::Point.new(0, 0), grid.height)
    all_visible += get_visible_trees(grid, row_l, vector_l)

    # Bottom.
    vector_b = Grid::Vector.new(0, -1)
    row_b = Grid::Vector.new(1, 0).project(Grid::Point.new(0, grid.height-1), grid.width)
    all_visible += get_visible_trees(grid, row_b, vector_b)

    # Right.
    vector_r = Grid::Vector.new(-1, 0)
    row_r = Grid::Vector.new(0, 1).project(Grid::Point.new(grid.width-1, 0), grid.height)
    all_visible += get_visible_trees(grid, row_r, vector_r)

    all_visible.uniq.size
end

def get_scenic_score_for_line(grid, origin_tree, line)
    score = 0
    line.each do |l|
        score += 1
        if grid[l] >= origin_tree
            return score
        end
    end

    score
end

def get_scenic_score(grid, point)
    # Get the four lines, ignoring the origin point
    # - which will be the first element in each line.
    line_u = Grid::Vector.new(0, -1).project(point, point.y + 1)[1..-1]
    line_d = Grid::Vector.new(0, 1).project(point, grid.height - point.y)[1..-1]
    line_l = Grid::Vector.new(-1, 0).project(point, point.x + 1)[1..-1]
    line_r = Grid::Vector.new(1, 0).project(point, grid.width - point.x)[1..-1]

    origin_tree = grid[point]

    score_u = get_scenic_score_for_line(grid, origin_tree, line_u)
    score_d = get_scenic_score_for_line(grid, origin_tree, line_d)
    score_l = get_scenic_score_for_line(grid, origin_tree, line_l)
    score_r = get_scenic_score_for_line(grid, origin_tree, line_r)

    score_u * score_d * score_l * score_r
end

def part2(input)
    grid = Grid::parse(input)
    highest_score = 0
    grid.each_point do |p|
        score = get_scenic_score(grid, p)
        if score > highest_score
            highest_score = score
        end
    end

    highest_score
end

AoC::example(day: 8, part: 1, expected: 21) do |input|
    part1(input)
end

AoC::solution(day: 8, part: 1) do |input|
    part1(input)
end

AoC::example(day: 8, part: 2, expected: 8) do |input|
    part2(input)
end

AoC::solution(day: 8, part: 2) do |input|
    part2(input)
end
