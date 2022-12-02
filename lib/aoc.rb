# Helper functions for handling some of the repeated functionality
# involved in writing solutions for Advent of Code puzzles.
#
# For example, testing implementations against a known example, loading
# data from files, etc.
module AoC
    def self.data(day, filename)
        File.read(File.join('data', "day#{day}", filename))
    end

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
end
