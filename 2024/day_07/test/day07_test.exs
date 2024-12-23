defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  test "part 1 example" do
    assert Day07.part1("example.txt") == 3749
  end

  test "part 1" do
    assert Day07.part1("input.txt") == 6_083_020_304_036 
  end

  test "test_operators/1" do
    assert Day07.test_operators({190, [10, 19]})
    assert Day07.test_operators({3267, [81, 40, 27]})
    refute Day07.test_operators({83, [17, 5]})
    refute Day07.test_operators({156, [15, 6]})
    refute Day07.test_operators({7290, [6, 8, 6, 15]})
    refute Day07.test_operators({161_011, [16, 10, 13]})
    refute Day07.test_operators({192, [17, 8, 14]})
    refute Day07.test_operators({21037, [9, 7, 18, 13]})
    assert Day07.test_operators({292, [11, 6, 16, 20]})
  end

  test "operators/1 code gen" do
    assert Day07.operators([1, 2]) == [[:+], [:*]]
    assert Day07.operators([1, 2, 3]) == [[:+, :+], [:+, :*], [:*, :+], [:*, :*]]

    assert Day07.operators([1, 2, 3, 4]) ==
             [
               [:+, :+, :+],
               [:+, :+, :*],
               [:+, :*, :+],
               [:+, :*, :*],
               [:*, :+, :+],
               [:*, :+, :*],
               [:*, :*, :+],
               [:*, :*, :*]
             ]
  end
end
