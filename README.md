# advent-of-code-2022

This repository is my attempt at Advent of Code for 2022!

This year I'm attempting AoC in Ruby, a language I have several years of experience in.
I'm doing this because I'm going to be quite busy over the holiday period this year, and I would
like to be able to focus more on solving the puzzles than learning a new language!

## Goals

* Solidify my Ruby skills
* Exercise my brain
* Have fun!

## Reading my Solutions

When I'm solving Advent of Code problems, I like to be able to make clear reference to
the examples given. For this reason, I've constructed a framework which allows me to declare
the examples for each day, along with their expected values.

The `AoC::example` method allows me to specify a day and part (e.g. day 2, part 1) and give
the value expected for an example. I can then execute my solution and the result will be automatically
compared to the expected value!

The `AoC::solution` method declares a solution to a particular part of a day's problem.
It behaves in a similar way to `AoC::example`, only it does not expect a particular result.

Both methods time the executed code, giving me an idea of the efficiency of my solutions.
