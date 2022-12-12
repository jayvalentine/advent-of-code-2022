require_relative 'lib/aoc'
require_relative 'lib/grid'

# Given:
#     A finish point
#     A map of points to their parent points
#
# Return the path from the origin point to the finish point.
def get_path(finish, parents)
    loc = finish
    path = []
    until (parents[loc].nil?)
        path << loc
        loc = parents[loc]
    end

    path.reverse
end

# Given:
#     A grid where each grid[p] is the accessible neighbours from p
#     A starting point
#     An end point
#
# Perform a breadth-first-search to find the shortest route from
# start to end.
def bfs(grid, start, finish)
    loc = start
    explored = { start => true }
    queue = [start]
    parent = {}

    until queue.empty?
        v = queue.shift

        if v == finish
            return get_path(v, parent)
        end

        grid[v].each do |w|
            unless explored.has_key?(w)
                explored[w] = true
                parent[w] = v
                queue << w
            end
        end
    end

    nil
end

def get_grid(input)
    # Parse the grid.
    # We use the special values -1 and -2 to represent
    # the start and end, respectively.
    Grid::parse(input) do |c|
        if c == "S"
            -1
        elsif c == "E"
            -2
        else
            # Elevation represented in lower-case a-z,
            # where a is lowest and z is highest.
            # Convert this to a numerical representation.
            c.ord - 97
        end
    end
end

# Given a grid of elevation values, returns a grid
# where each square contains the possible neighbours
# (i.e. the coordinates of the neighbours that can be visited from that square).
def get_neighbour_grid(grid)
    grid.transform { |p, v| grid.neighbours(p).filter { |p2, v2| v2 <= v+1 }.map { |p2, _| p2 } }
end

def print_path(grid, start, goal, path)
    # Get a grid of characters to print.
    print_grid = grid.transform do |p, _|
        if start == p
            "S"
        elsif goal == p
            "E"
        elsif path.include? p
            "x"
        else
            "."
        end
    end

    puts print_grid
end

def part1(input)
    grid = get_grid(input)

    # Find the point corresponding to the start.
    start = grid.find(-1)

    # Find the point corresponding to the end.
    goal = grid.find(-2)

    # Now set the proper elevations of the start and end.
    grid[start] = 0
    grid[goal] = 25

    # Map each square to its possible neighbours
    neighbour_grid = get_neighbour_grid(grid)

    # Do the BFS to find the shortest path.
    path = bfs(neighbour_grid, start, goal)

    path.size
end

def part2(input)
    grid = get_grid(input)

    # Find the point corresponding to the end.
    goal = grid.find(-2)
    start = grid.find(-1)

    # Now set the proper elevations of the start and end.
    grid[start] = 0
    grid[goal] = 25

    # Map each square to its possible neighbours.
    neighbour_grid = get_neighbour_grid(grid)

    # For each point, if that point is at elevation 'a' (0),
    # find a path to the goal.
    paths = []
    grid.each do |p, v|
        if v == 0
            path = bfs(neighbour_grid, p, goal)
            paths << path unless path.nil?
        end
    end

    paths.map(&:size).min
end

AoC::example(day: 12, part: 1, expected: 31) do |input|
    part1(input)
end

AoC::solution(day: 12, part: 1) do |input|
    part1(input)
end

AoC::example(day: 12, part: 2, expected: 29) do |input|
    part2(input)
end

AoC::solution(day: 12, part: 2) do |input|
    part2(input)
end
