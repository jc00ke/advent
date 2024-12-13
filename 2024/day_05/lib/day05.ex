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

    rejected = Enum.reject(updates, fn update ->
      updates_in_order?(rules, update)
    end)

    fix_updates(rules, rejected)
    |> get_middle()
    |> Enum.sum()
  end

  def fix_updates(rules, updates, new_updates \\ [])
  def fix_updates(_rules, [], new_updates) do
    Enum.reject(new_updates, fn u -> is_nil(u) end)# |> Enum.uniq()
  end
  def fix_updates(rules, [head | tail], new_updates) do
    next = Enum.at(tail, 0)

    result =
      cond do
        is_nil(next) -> [head, nil]
        Enum.member?(rules, {head, next}) -> [head, next]
        true -> [next, head]
      end
      |> dbg(charlists: :as_lists)
    fix_updates(rules, tail, new_updates ++ result)
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
