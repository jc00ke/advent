defmodule Day07 do
  def part1(path) do
    prepare(path)
    |> Enum.group_by(&test_operators/1)
    |> then(fn %{true => equations} ->
      Enum.map(equations, fn {test_value, _numbers} ->
        test_value
      end)
      |> Enum.sum()
    end)

    # |> dbg(charlists: :as_lists)
  end

  def test_operators({test_value, numbers}) do
    Enum.any?([
      Enum.sum(numbers) == test_value,
      Enum.product(numbers) == test_value
      # test_operators(numbers, test_value)
    ])
  end

  def operators(numbers) do
    vars =
      Enum.map(1..(length(numbers) - 1), fn _ ->
        "var_#{System.unique_integer([:positive, :monotonic])}"
      end)

    args = Enum.map_join(vars, ", ", fn var -> "#{var} <- ops" end)
    ret = Enum.join(vars, ", ")
    code = "ops = [:+, :*]; for #{args}, do: [#{ret}]"

    {ops, _} = Code.eval_string(code)
    ops
  end

  def prepare(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(:binary.compile_pattern(["\n", ": "]))
    |> Enum.chunk_every(2)
    |> Enum.map(fn [test_value, numbers] ->
      {
        String.to_integer(test_value),
        String.split(numbers, " ") |> Enum.map(&String.to_integer/1)
      }
    end)
  end
end
