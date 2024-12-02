defmodule Aoc2024.Solutions.Y24.Day02 do
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

    input |> Input.stream!(trim: true) |> Enum.map(&parse_reports/1)
  end

  def part_one(problem) do
    # This function receives the problem returned by parse/2 and must return
    # today's problem solution for part one.

    problem |> Enum.count(&is_safe/1)
  end

  def part_two(problem) do
    problem |> Enum.count(&is_tolerated/1)
  end

  defp parse_reports(line) do
    String.split(line) |> Enum.map(&String.to_integer/1)
  end

  defp is_safe([head | tail]), do: increases(head, tail) or decreases(head, tail)

  defp increases(_head, []), do: true

  defp increases(head, [next | tail]) when head + 1 <= next and next <= head + 3,
    do: increases(next, tail)

  defp increases(_head, _tail), do: false

  defp decreases(_head, []), do: true

  defp decreases(head, [next | tail]) when head - 1 >= next and next >= head - 3,
    do: decreases(next, tail)

  defp decreases(_head, _tail), do: false

  defp is_tolerated([a | [b | tail]]) do
    increases_with_tolerance(a, b, tail) or increases(b, tail) or
      decreases_with_tolerance(a, b, tail) or decreases(b, tail)
  end

  defp increases_with_tolerance(_a, _b, []), do: true

  defp increases_with_tolerance(a, b, [c | tail]) do
    cond do
      increases(a, [c | tail]) -> true
      increases(a, [b | tail]) -> true
      a + 1 <= b and b <= a + 3 -> increases_with_tolerance(b, c, tail)
      true -> false
    end
  end

  defp decreases_with_tolerance(_a, _b, []), do: true

  defp decreases_with_tolerance(a, b, [c | tail]) do
    cond do
      decreases(a, [c | tail]) -> true
      decreases(a, [b | tail]) -> true
      a - 1 >= b and b >= a - 3 -> decreases_with_tolerance(b, c, tail)
      true -> false
    end
  end
end
