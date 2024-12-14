defmodule Day05 do
  @moduledoc """
  Documentation for `Day05`.
  """
  def part1(path) do
    %{rules: rules, updates: updates} = process_input(path)

    Enum.filter(updates, fn update ->
      updates_in_order?(rules, update)
    end)
    |> get_middle()
    |> Enum.sum()
  end

  def part2(path) do
    %{rules: rules, updates: updates} = process_input(path)

    rejected =
      Enum.reject(updates, fn update ->
        updates_in_order?(rules, update)
      end)

    Enum.map(rejected, fn r -> fix_updates(rules, r) end)
    |> get_middle()
    |> Enum.sum()
  end

  def fix_updates(rules, updates) do
    Enum.sort(updates, fn l, r ->
      Enum.member?(rules, {l, r})
    end)
  end

  def updates_in_order?(_rules, []), do: true

  def updates_in_order?(rules, [head | tail]) do
    next = Enum.at(tail, 0)

    if is_nil(next) || Enum.member?(rules, {head, next}) do
      updates_in_order?(rules, tail)
    end
  end

  def process_input(path) do
    lines =
      File.read!(path)
      |> String.split("\n")

    %{rules: rules, updates: updates} =
      Enum.group_by(lines, fn line ->
        cond do
          String.contains?(line, "|") -> :rules
          String.contains?(line, ",") -> :updates
          true -> nil
        end
      end)

    rules =
      Enum.map(rules, fn rule ->
        [l, r] = String.split(rule, "|")
        {String.to_integer(l), String.to_integer(r)}
      end)

    updates =
      Enum.map(updates, fn update ->
        String.split(update, ",") |> Enum.map(&String.to_integer/1)
      end)

    %{rules: rules, updates: updates}
  end

  defp get_middle(updates) do
    Enum.map(updates, fn update ->
      Enum.at(update, floor(length(update) / 2))
    end)
  end
end
