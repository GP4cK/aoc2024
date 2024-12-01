defmodule Aoc2024.Solutions.Y24.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    # This function will receive the input path or an %AoC.Input.TestInput{}
    # struct. To support the test you may read both types of input with either:
    #
    # * Input.stream!(input), equivalent to File.stream!/1
    # * Input.stream!(input, trim: true), equivalent to File.stream!/2
    # * Input.read!(input), equivalent to File.read!/1
    #
    # The role of your parse/2 function is to return a "problem" for the solve/2
    # function.
    #
    # For instance:
    #
    # input
    # |> Input.stream!()
    # |> Enum.map!(&my_parse_line_function/1)

    Input.stream!(input, trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({[], []}, fn [l, r], acc -> {[l] ++ elem(acc, 0), [r] ++ elem(acc, 1)} end)
  end

  def parse_line(line), do: String.split(line) |> Enum.map(&String.to_integer/1)

  def part_one(problem) do
    {left, right} = problem
    left = Enum.sort(left)
    right = Enum.sort(right)
    Enum.zip(left, right) |> Enum.map(fn {l, r} -> abs(r - l) end) |> Enum.sum()
  end

  def part_two(problem) do
    {left, right} = problem
    left |> Enum.map(fn l -> l * Enum.count(right, fn x -> x == l end) end) |> Enum.sum()
  end
end
