defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

  test "part 1 example" do
    assert Day09.part1("example.txt") == 1928
  end

  # this takes about 35 seconds on my Dell.
  # test "part 1" do
  #   assert Day09.part1("input.txt") == 6_340_197_768_906
  # end

  test "id/1" do
    assert Day09.id("12345") == id("12345")

    assert Day09.id("2333133121414131402") == id("2333133121414131402")

    assert Day09.id("233313312141413140232") == id("233313312141413140232")
  end

  test "compact/1" do
    assert Day09.compact(id("12345")) == [0, 2, 2, 1, 1, 1, 2, 2, 2]

    assert Day09.compact(id("2333133121414131402")) ==
             [0, 0, 9, 9, 8, 1, 1, 1, 8, 8, 8, 2, 7, 7, 7, 3, 3, 3, 6, 4, 4, 6, 5, 5, 5, 5, 6, 6]

    assert Day09.compact(id("233313312141413140232")) ==
             [
               0,
               0,
               10,
               10,
               9,
               1,
               1,
               1,
               9,
               8,
               8,
               2,
               8,
               8,
               7,
               3,
               3,
               3,
               7,
               4,
               4,
               7,
               5,
               5,
               5,
               5,
               6,
               6,
               6,
               6
             ]
  end

  test "filesystem_checksum/1 with a string" do
    assert Day09.filesystem_checksum([
             0,
             0,
             9,
             9,
             8,
             1,
             1,
             1,
             8,
             8,
             8,
             2,
             7,
             7,
             7,
             3,
             3,
             3,
             6,
             4,
             4,
             6,
             5,
             5,
             5,
             5,
             6,
             6
           ]) == 1928
  end

  @dot "."

  def id("12345"), do: [0, @dot, @dot, 1, 1, 1, @dot, @dot, @dot, @dot, 2, 2, 2, 2, 2]

  def id("2333133121414131402"),
    do: [
      0,
      0,
      @dot,
      @dot,
      @dot,
      1,
      1,
      1,
      @dot,
      @dot,
      @dot,
      2,
      @dot,
      @dot,
      @dot,
      3,
      3,
      3,
      @dot,
      4,
      4,
      @dot,
      5,
      5,
      5,
      5,
      @dot,
      6,
      6,
      6,
      6,
      @dot,
      7,
      7,
      7,
      @dot,
      8,
      8,
      8,
      8,
      9,
      9
    ]

  def id("233313312141413140232"),
    do: [
      0,
      0,
      @dot,
      @dot,
      @dot,
      1,
      1,
      1,
      @dot,
      @dot,
      @dot,
      2,
      @dot,
      @dot,
      @dot,
      3,
      3,
      3,
      @dot,
      4,
      4,
      @dot,
      5,
      5,
      5,
      5,
      @dot,
      6,
      6,
      6,
      6,
      @dot,
      7,
      7,
      7,
      @dot,
      8,
      8,
      8,
      8,
      9,
      9,
      @dot,
      @dot,
      @dot,
      10,
      10
    ]
end
