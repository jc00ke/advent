defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  test "process_input/1" do
    assert Day05.process_input("example.txt") ==
             %{
               rules: [
                 {47, 53},
                 {97, 13},
                 {97, 61},
                 {97, 47},
                 {75, 29},
                 {61, 13},
                 {75, 53},
                 {29, 13},
                 {97, 29},
                 {53, 29},
                 {61, 53},
                 {97, 53},
                 {61, 29},
                 {47, 13},
                 {75, 47},
                 {97, 75},
                 {47, 61},
                 {75, 61},
                 {47, 29},
                 {75, 13},
                 {53, 13}
               ],
               updates: [
                 [75, 47, 61, 53, 29],
                 [97, 61, 53, 29, 13],
                 [75, 29, 13],
                 [75, 97, 47, 61, 53],
                 [61, 13, 29],
                 [97, 13, 75, 29, 47]
               ]
             }
  end

  test "updates_in_order?/1" do
    graph = Day05.part1("example.txt")
    assert Day05.updates_in_order?(graph, [75, 47, 61, 53, 29])
    assert Day05.updates_in_order?(graph, [97, 61, 53, 29, 13])
    assert Day05.updates_in_order?(graph, [75, 29, 13])
    refute Day05.updates_in_order?(graph, [75, 97, 47, 61, 53])
    refute Day05.updates_in_order?(graph, [61, 13, 29])
    refute Day05.updates_in_order?(graph, [97, 13, 75, 29, 47])
  end

  test "part 1 example" do
    # assert Day05.part1("example.txt") == 143
    Day05.part1("input.txt") |> dbg()
  end
end
