defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "part 1 example" do
    input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    assert Day03.part1(input) == 161
  end

  test "part 1" do
    File.read!("input.txt") |> Day03.part1() |> IO.inspect()
  end
end
