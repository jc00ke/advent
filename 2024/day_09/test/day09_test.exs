defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

  test "part 1 example" do
    assert Day09.part1("example.txt") == 1928
  end

  test "id/1" do
    assert Day09.id("12345") == "0..111....22222"
  end
end
