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
        actual = yield data(day, "example.txt")

        # Print the result.
        expected_string = ""
        if actual != expected
            expected_string = " (expected #{expected})"
        end
        puts "Day #{day}, example #{part} - result: #{actual}#{expected_string}"
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
    def self.puzzle(day:, part:)
        actual = yield data(day, "puzzle.txt")

        puts "Day #{day}, puzzle #{part} - result: #{actual}"
    end
end
