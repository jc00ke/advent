defmodule Day03 do
  @moduledoc """
  Documentation for `Day03`.
  """
  def part1(input) do
    Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)/, input)
    |> Enum.map(fn [mul] -> Regex.scan(~r/\d+/, mul) |> List.flatten() end)
    |> Enum.map(fn [l, r] -> String.to_integer(l) * String.to_integer(r) end)
    |> Enum.sum()
  end
end
