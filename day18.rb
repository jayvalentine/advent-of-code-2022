require 'set'

require_relative 'lib/aoc'
require_relative 'lib/grid'

def get_cubes(input)
    cubes = input.split("\n").map do |s|
        dims = s.split(",").map(&:to_i)
        Grid::Point.new(dims[0], dims[1], dims[2])
    end

    Set.new(cubes)
end

FACES = [
    Grid::Vector.new(1, 0, 0),
    Grid::Vector.new(-1, 0, 0),
    Grid::Vector.new(0, 1, 0),
    Grid::Vector.new(0, -1, 0),
    Grid::Vector.new(0, 0, 1),
    Grid::Vector.new(0, 0, -1),
]

def part1(input)
    cubes = get_cubes(input)

    # For each cube count it's neighbours - the number
    # of other cubes with a distance of 1 in only one dimension.
    neighbours = cubes.map do |c|
        FACES.count do |f|
            cubes.include?(c + f)
        end
    end

    # Now total up all the exposed sides. Each cube has 6 sides,
    # so any sides not covered by neighbours are exposed.
    neighbours.map { |n| 6 - n }.sum
end

def part2(input)
    cubes = get_cubes(input)

    # Get all the air-cubes.
    min_x = cubes.map(&:x).min
    max_x = cubes.map(&:x).max
    min_y = cubes.map(&:y).min
    max_y = cubes.map(&:y).max
    min_z = cubes.map(&:z).min
    max_z = cubes.map(&:z).max
    air_cubes = []
    (min_z..max_z).each do |z|
        (min_y..max_y).each do |y|
            (min_x..max_x).each do |x|
                p = Grid::Point.new(x, y, z)
                air_cubes << p unless cubes.include? p
            end
        end
    end
    
    # For each cube get the directions in which it does not
    # have a neighbour.
    cubes = cubes.map do |c|
        open_faces = FACES.reject do |f|
            cubes.include?(c + f)
        end

        [c, open_faces]
    end

    # For each cube, count the number of non-neighbour
    # faces which do not face another cube (even at distance).
    external_faces = cubes.map do |c, faces|
        faces.count do |f|
            # f is an x, y, z vector where only one element
            # is non-zero. We can tell if this face faces
            # another cube by seeing if another cube exists
            # on the line the vector points.
            if f.dx != 0
                cubes.any? { |c2, _| ((c2.x - c.x) / f.dx) > 0 }
            elsif f.dy != 0
                cubes.any? { |c2, _| ((c2.y - c.y) / f.dy) > 0 }
            elsif f.dz != 0
                cubes.any? { |c2, _| ((c2.z - c.z) / f.dz) > 0 }
            else
                raise "Invalid face: #{f}"
            end
        end
    end

    external_faces.map { |n| 6 - n }.sum
end

AoC::example(day: 18, part: 1, expected: 64) do |input|
    part1(input)
end

AoC::solution(day: 18, part: 1) do |input|
    part1(input)
end

AoC::example(day: 18, part: 2, expected: 58) do |input|
    part2(input)
end
