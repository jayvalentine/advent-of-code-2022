require_relative 'lib/aoc'

class DeviceFile
    attr_reader :parent, :name, :size

    def initialize(parent, name, size)
        @parent = parent
        @name = name
        @size = size
    end

    def dir?
        false
    end

    def to_s
        "#{@size} #{@name}"
    end
end

class DeviceDir < DeviceFile
    attr_reader :files

    def initialize(parent, name)
        super(parent, name, 0)
        @files = []
    end

    def dir?
        true
    end

    def to_s
        s = "#{@name}\n"

        @files.each do |f|
            f.to_s.split("\n").each do |s2|
                s += "    #{s2}\n"
            end
        end

        s
    end

    def size
        @files.map(&:size).sum
    end

    def add_file(name, size)
        @files << DeviceFile.new(self, name, size)
    end

    def add_dir(name)
        @files << DeviceDir.new(self, name)
    end

    def [](name)
        @files.find { |f| f.name == name }
    end
end

def get_directories_under_limit(dir, limit)
    dirs = []

    if dir.size <= limit
        dirs << dir
    end

    dir.files.select(&:dir?).each do |subdir|
        dirs += get_directories_under_limit(subdir, limit)
    end

    dirs
end

DIR_LIMIT = 100000

def get_directories(input)
    input = input.split("\n")
    root = DeviceDir.new(nil, "/")
    cwd = root

    until (line = input.shift).nil?
        if line.start_with? "$ "
            # Command
            cmd = line.split[1..-1]
            if cmd[0] == "cd"
                dest = cmd[1]
                if dest == "/"
                    cwd = root
                elsif dest == ".."
                    cwd = cwd.parent
                else
                    # Find file with given name in current directory.
                    cwd = cwd[dest]
                end
            end
        elsif line.start_with? "dir "
            # Directory entry
            dir_name = line.split[1]
            cwd.add_dir(dir_name)
        else
            # File
            file_size = line.split[0].to_i
            file_name = line.split[1]
            cwd.add_file(file_name, file_size)
        end
    end

    root
end

def part1(input)
    root = get_directories(input)

    dirs = get_directories_under_limit(root, DIR_LIMIT)

    dirs.map(&:size).sum
end

TOTAL_SPACE = 70000000
SPACE_NEEDED = 30000000

def get_smallest_over_limit(dir, smallest, limit)
    # If deleting this directory will not free enough space,
    # we can ignore it and its children.
    if dir.size < limit
        return smallest
    end

    # If this directory is smaller than any we've seen
    # then make a note of this so we compare
    # other directories against this one.
    if dir.size < smallest.size
        smallest = dir
    end

    # Now check all the subdirectories
    dir.files.select(&:dir?).each do |subdir|
        smallest = get_smallest_over_limit(subdir, smallest, limit)
    end

    smallest
end

def part2(input)
    root = get_directories(input)

    # Calculate the amount of space we need to free up.
    used_space = root.size

    space_to_free = SPACE_NEEDED - (TOTAL_SPACE - used_space)

    smallest = DeviceFile.new(nil, "inf", Float::INFINITY)

    get_smallest_over_limit(root, smallest, space_to_free).size
end

AoC::example(day: 7, part: 1, expected: 95437) do |input|
    part1(input)
end

AoC::solution(day: 7, part: 1) do |input|
    part1(input)
end

AoC::example(day: 7, part: 2, expected: 24933642) do |input|
    part2(input)
end

AoC::solution(day: 7, part: 2) do |input|
    part2(input)
end
