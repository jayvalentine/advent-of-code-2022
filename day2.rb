require_relative 'lib/aoc'

# Shapes for rock-paper-scissors.
# Each shape's value is it's score value.
SHAPE_ROCK = 1
SHAPE_PAPER = 2
SHAPE_SCISSORS = 3

# Mapping of strategy value to shapes.
OPPONENT_MAPPING = {
    'A' => SHAPE_ROCK,
    'B' => SHAPE_PAPER,
    'C' => SHAPE_SCISSORS
}

RESPONSE_MAPPING = {
    'X' => SHAPE_ROCK,
    'Y' => SHAPE_PAPER,
    'Z' => SHAPE_SCISSORS
}

# Given an opponent's play, this map gives the corresponding winning move.
WINNING_MOVE = {
    SHAPE_ROCK => SHAPE_PAPER,
    SHAPE_PAPER => SHAPE_SCISSORS,
    SHAPE_SCISSORS => SHAPE_ROCK
}

def puzzle(day, number)
    actual = yield

    puts "Day #{day}, puzzle #{number} - result: #{actual}"
end

class Play
    def initialize(opponent, response)
        @opponent = opponent
        @response = response
    end

    # A play is a win if the response is the winning move for the
    # opponent's move.
    def win?
        @response == WINNING_MOVE[@opponent]
    end

    # A play is a loss if the opponent's move is the winning move for
    # the response.
    def loss?
        @opponent == WINNING_MOVE[@response]
    end

    # A play is a draw if it isn't a win or a loss.
    def draw?
        !win? && !loss?
    end

    # The score of the play is a combination of the score for the result:
    # * WIN: 6
    # * DRAW: 3
    # * LOSS: 0
    #
    # and the score for the move played in response.
    def score
        result_score = if win?
            6
        elsif draw?
            3
        elsif loss?
            0
        end

        result_score + @response
    end
end

def get_plays(strategy)
    plays = []
    strategy.each do |s|
        parts = s.split
        opponent = OPPONENT_MAPPING[parts.first]
        response = RESPONSE_MAPPING[parts.last]
        plays << Play.new(opponent, response)
    end

    plays
end

def get_plays_part2(strategy)
    plays = []

    strategy.each do |s|
        parts = s.split
        opponent = OPPONENT_MAPPING[parts.first]

        # Second half of strategy indicates what the game result should be.
        # We need to choose the right shape to play to get that result.
        # X: loss
        # Y: draw
        # Z: win
        response = case parts.last
        when 'X'
            # The move for which the opponent's move would win.
            WINNING_MOVE.keys.find { |m| WINNING_MOVE[m] == opponent }
        when 'Y'
            # The same move as the opponent.
            opponent
        when 'Z'
            # The move that would beat the opponent.
            WINNING_MOVE[opponent]
        end

        plays << Play.new(opponent, response)
    end

    plays
end

AoC::example(day: 2, part: 1, expected: 15) do |example|
    plays = get_plays(example.split("\n"))
    plays.map(&:score).sum
end

puzzle(2, 1) do
    plays = get_plays(File.read("data/day2/puzzle.txt").split("\n"))
    plays.map(&:score).sum
end

AoC::example(day: 2, part: 2, expected: 12) do |example|
    plays = get_plays_part2(example.split("\n"))
    plays.map(&:score).sum
end

puzzle(2, 2) do
    plays = get_plays_part2(File.read("data/day2/puzzle.txt").split("\n"))
    plays.map(&:score).sum
end
