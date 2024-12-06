defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "part 1" do
    assert Day02.part1("example.txt") == 2
    assert Day02.part1("input.txt") == 411
  end

  test "process/1" do
    assert %{safe: true} = Day02.process_line([7, 6, 4, 2, 1])
    assert %{safe: false} = Day02.process_line([1, 2, 7, 8, 9])
    assert %{safe: false} = Day02.process_line([9, 7, 6, 2, 1])
    assert %{safe: false} = Day02.process_line([1, 3, 2, 4, 5])
    assert %{safe: false} = Day02.process_line([8, 6, 4, 4, 1])
    assert %{safe: true} = Day02.process_line([1, 3, 6, 7, 9])
  end

  test "part 2" do
    assert Day02.part2("example.txt") == 4
  end

  test "dampen_unsafe_report/1" do
    reports = %{
      false: [
        # 1 2 7 8 9: Unsafe regardless of which level is removed.
        %{line: [1, 2, 7, 8, 9], safe: false, current: 7, direction: :inc},
        # 9 7 6 2 1: Unsafe regardless of which level is removed.
        %{line: [9, 7, 6, 2, 1], safe: false, current: 2, direction: :dec},
        # 1 3 2 4 5: Safe by removing the second level, 3.
        %{line: [1, 3, 2, 4, 5], safe: false, current: 2, direction: :inc},
        # 8 6 4 4 1: Safe by removing the third level, 4.
        %{line: [8, 6, 4, 4, 1], safe: false, current: 4, direction: :dec}
      ],
      true: [
        # 7 6 4 2 1: Safe without removing any level.
        %{line: [7, 6, 4, 2, 1], safe: true, current: 1, direction: :dec},
        # 1 3 6 7 9: Safe without removing any level.
        %{line: [1, 3, 6, 7, 9], safe: true, current: 9, direction: :inc}
      ]
    }
  end
end
