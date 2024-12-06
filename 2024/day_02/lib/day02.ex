defmodule Day02 do
  @moduledoc """
  Documentation for `Day02`.
  """

  def part1(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> String.split(s, ~r{\s+}) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&process_line/1)
    |> Enum.count(fn %{safe: safe} -> safe end)
  end

  def process_line(line) do
    Enum.reduce_while(line, %{last: nil, direction: nil, safe: true}, fn x, acc ->
      cond do
        acc.safe == false ->
          {:halt, acc}

        is_nil(acc.last) ->
          {:cont, %{acc | last: x}}

        acc.last == x ->
          {:halt, %{acc | safe: false}}

        acc.direction == :dec && acc.last < x ->
          {:halt, %{acc | safe: false}}

        acc.direction == :inc && acc.last > x ->
          {:halt, %{acc | safe: false, last: x}}

        acc.safe && acc.last > x && abs(acc.last - x) in 1..3 ->
          {:cont, %{acc | direction: :dec, last: x}}

        acc.safe && acc.last < x && abs(acc.last - x) in 1..3 ->
          {:cont, %{acc | direction: :inc, last: x}}

        true ->
          {:cont, %{acc | last: x, safe: false}}
      end
    end)
  end

  def part2(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> String.split(s, ~r{\s+}) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&process_line_with_dampener/1)
    |> Enum.group_by(& &1.safe)
    |> dbg()

    # |> Enum.count(fn %{safe: safe} -> safe end)
  end

  def process_line_with_dampener(line) do
    Enum.reduce_while(line, %{current: nil, direction: nil, safe: true, line: line}, fn x, acc ->
      cond do
        acc.safe == false ->
          {:halt, acc}

        is_nil(acc.current) ->
          {:cont, %{acc | current: x}}

        acc.current == x ->
          {:halt, %{acc | safe: false}}

        acc.direction == :dec && acc.current < x ->
          {:halt, %{acc | safe: false}}

        acc.direction == :inc && acc.current > x ->
          {:halt, %{acc | safe: false, current: x}}

        acc.safe && acc.current > x && abs(acc.last - x) in 1..3 ->
          {:cont, %{acc | direction: :dec, current: x}}

        acc.safe && acc.current < x && abs(acc.last - x) in 1..3 ->
          {:cont, %{acc | direction: :inc, current: x}}

        true ->
          {:cont, %{acc | current: x, safe: false}}
      end
    end)
  end
end
