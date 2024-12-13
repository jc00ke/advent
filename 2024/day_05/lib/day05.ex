defmodule Day05 do
  @moduledoc """
  Documentation for `Day05`.
  """
  def part1(path) do
    %{rules: rules, updates: updates} = process_input(path)

    rules_graph = graph(rules)

    Enum.filter(updates, fn update ->
      updates_in_order?(rules_graph, update)
    end)
    |> Enum.map(fn update ->
      Enum.at(update, floor(length(update) / 2))
    end)
    |> Enum.sum()
  end

  def graph(rules) do
    Enum.reduce(rules, :digraph.new(), fn {l, r}, g ->
      _vl = :digraph.add_vertex(g, l)
      _vr = :digraph.add_vertex(g, r)
      :digraph.add_edge(g, l, r)
      g
    end)
  end

  def updates_in_order?(graph, [head | tail]) do
    next = Enum.at(tail, 0)
    path = :digraph.get_path(graph, head, next)

    cond do
      is_nil(next) -> true
      is_list(path) -> updates_in_order?(graph, tail)
      path == false -> false
      true -> false
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
end
