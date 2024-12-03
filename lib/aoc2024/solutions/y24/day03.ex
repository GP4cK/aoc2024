defmodule Aoc2024.Solutions.Y24.Day03 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    problem |> calculate_sum()
  end

  def calculate_sum(corrupted_memory) do
    corrupted_memory
    |> String.split("mul(")
    |> Enum.drop(1)
    |> Enum.map(&parse_mul/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.sum()
  end

  defp parse_mul(chunk) do
    case String.split(chunk, ")") do
      [parameters | _] ->
        parameters
        |> String.split(",")
        |> Enum.map(&safe_to_integer/1)
        |> case do
          [x, y] when is_integer(x) and is_integer(y) -> x * y
          _ -> nil
        end

      _ ->
        nil
    end
  end

  defp safe_to_integer(str) do
    case Integer.parse(str) do
      {int, ""} -> int
      _ -> nil
    end
  end

  def part_two(problem) do
    problem |> String.split("don't()") |> sum_each_part()
  end

  defp sum_each_part([head | tail]) do
    first = calculate_sum(head)
    rest = tail |> Enum.map(&count_after_do/1)
    first + Enum.sum(rest)
  end

  defp count_after_do(str) do
    String.split(str, "do()") |> Enum.drop(1) |> Enum.join(".") |> calculate_sum()
  end
end
