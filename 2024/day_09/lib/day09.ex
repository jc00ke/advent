defmodule Day09 do
  require Logger
  @dot "."
  def part1(path) do
    process(path)
    |> id()
    |> compact()
    |> filesystem_checksum()
  end

  def part1_timed(path) do
    {duration, result} = :timer.tc(fn -> part1(path) end)
    took = Float.round(duration / 1000000, 4)
    Logger.info("Took #{took} seconds")
    result
  end

  def id(disk_map) do
    %{files: files, free_space: free_space} =
      String.split(disk_map, "", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.group_by(fn {_n, i} -> if Integer.mod(i, 2) == 0, do: :files, else: :free_space end)

    numbers =
      Enum.map(files, fn {file_block, file_index} ->
        Stream.repeatedly(fn -> round(file_index / 2) end)
        |> Enum.take(file_block)
      end)

    dots =
      Enum.map(free_space, fn {file_block, _file_index} ->
        Stream.repeatedly(fn -> @dot end) |> Enum.take(file_block)
      end)

    join(numbers, dots)
  end

  defp join(numbers, dots, s \\ [])

  defp join([n], [], s) do
    [n | s] |> Enum.reverse() |> List.flatten()
  end

  defp join([n | numbers], [d | dots], s) do
    join(numbers, dots, [d | [n | s]])
  end

  def compact(id) do
    id
    |> Enum.map(&maybe_parse_integer/1)
    |> do_compact()
  end

  defp maybe_parse_integer(@dot), do: @dot
  defp maybe_parse_integer(d), do: d

  defp do_compact(id_digits, numbers \\ [], dots \\ [])

  defp do_compact([], [nil | rest], _dots) do
    Enum.reverse(rest)
  end

  defp do_compact([], numbers, _dots) do
    Enum.reverse(numbers)
  end

  defp do_compact([first | rest], numbers, dots) do
    if first == @dot do
      {last, new_rest} = List.pop_at(rest, -1)

      if last == @dot do
        do_compact([first | new_rest], numbers, [last | dots])
      else
        do_compact(new_rest, [last | numbers], [@dot | dots])
      end
    else
      do_compact(rest, [first | numbers], dots)
    end
  end

  def filesystem_checksum(compacted_blocks) do
    Enum.with_index(compacted_blocks, fn file_id, index ->
      file_id * index
    end)
    |> Enum.sum()
  end

  def process(path) do
    File.read!(path) |> String.trim()
  end
end
