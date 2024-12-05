defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "part 1 example" do
    assert Day01.part1("example.txt") == 11
  end

  test "part 1" do
    assert Day01.part1("input.txt") == 2_756_096
  end

  test "part 2 example" do
    assert Day01.part2("example.txt") == 31
  end

  test "part 2" do
    assert Day01.part2("input.txt") == 23_117_829
  end
end
