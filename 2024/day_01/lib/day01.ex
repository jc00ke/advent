defmodule Day01 do
  def part1(path) do
    [left, right] = file_to_lists(path)

    left = strings_to_ints(left) |> Enum.sort()
    right = strings_to_ints(right) |> Enum.sort()

    Enum.zip_reduce(left, right, 0, fn l, r, acc ->
      acc + abs(l - r)
    end)
  end

  def part2(path) do
    [left, right] = file_to_lists(path)

    left = strings_to_ints(left)
    right = strings_to_ints(right)

    Enum.into(left, [], fn l -> {l, Enum.count(right, fn r -> r == l end)} end)
    |> Enum.map(fn tuple -> Tuple.product(tuple) end)
    |> Enum.sum()
  end

  defp file_to_lists(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> String.split(s, ~r{\s+}) end)
    |> Enum.zip()
  end

  defp strings_to_ints(tuple) do
    Tuple.to_list(tuple) |> Enum.map(&String.to_integer/1)
  end
end
