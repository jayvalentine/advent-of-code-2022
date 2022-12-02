require 'benchmark'

# Helper functions for handling some of the repeated functionality
# involved in writing solutions for Advent of Code puzzles.
#
# For example, testing implementations against a known example, loading
# data from files, etc.
module AoC
    # Gets the contents of a data file associated with a particular day.
    #
    # day: day in advent calendar (starting at 1)
    # filename: name of file to read
    def self.data(day, filename)
        File.read(File.join('data', "day#{day}", filename))
    end

    # Prints a sequence of values in a tabulated form, with 20 columns
    # per string.
    def self.tabulate(*values)
        out = ""
        values.each do |v|
            out += " %-18s " % v.to_s
            out += "|"
        end

        out
    end

    # Declare an AoC example.
    #
    # day: day in advent calendar (starting at 1)
    # part: part of puzzle (part 1 or 2)
    # expected: expected value for example
    #
    # The block passed is evaluated and the result compared
    # against the expected value.
    #
    # The block has a single parameter - the puzzle
    # data read from the corresponding file in the data/
    # directory.
    #
    # A message is emitted showing the actual value and
    # indicating any deviation from expectation.
    def self.example(day:, part:, expected:)
        # Get the actual outcome from the passed block.
        # Pass the example data to the block.
        actual = nil
        time = Benchmark.measure do
            actual = yield data(day, "example.txt")
        end

        # Print the result.
        expected_string = ""
        if actual != expected
            expected_string = " (expected #{expected})"
        end
        puts tabulate("Day #{day}, example #{part}", "#{time.real.round(5)}s", "#{actual}#{expected_string}")
    end

    # Declare an AoC puzzle solution.
    #
    # day: day in advent calendar (starting at 1)
    # part: part of puzzle (part 1 or 2)
    #
    # The block passed is evaluated and the value
    # (solution to the puzzle) printed.
    #
    # The block has a single parameter - the puzzle
    # data read from the corresponding file in the data/
    # directory.
    def self.solution(day:, part:)
        actual = nil
        time = Benchmark.measure do
            actual = yield data(day, "puzzle.txt")
        end

        puts tabulate("Day #{day}, solution #{part}", "#{time.real.round(5)}s", actual)
    end
end
