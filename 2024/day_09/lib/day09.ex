defmodule Day09 do
  @dot "."
  def part1(path) do
    process(path)
    |> id()
    |> compact()
    |> filesystem_checksum()
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
        |> Enum.join()
      end)

    dots =
      Enum.map(free_space, fn {file_block, _file_index} ->
        Stream.repeatedly(fn -> @dot end) |> Enum.take(file_block) |> Enum.join()
      end)

    join(numbers, dots)
  end

  defp join(numbers, dots, s \\ "")

  defp join([n], [], s) do
    s <> n
  end

  defp join([n | numbers], [d | dots], s) do
    join(numbers, dots, s <> n <> d)
  end

  def compact(id) do
    String.split(id, "", trim: true)
    |> Enum.map(&maybe_parse_integer/1)
    |> do_compact()
  end

  defp maybe_parse_integer("."), do: "."
  defp maybe_parse_integer(d), do: String.to_integer(d)

  defp do_compact(id_digits, numbers \\ [], dots \\ [])

  defp do_compact([], numbers, dots) do
    if IEx.started?() do
      numbers
    else
      nms = Enum.join(numbers, "")
      dts = Enum.join(dots, "")
      nms <> dts
    end
  end

  defp do_compact([first | rest], numbers, dots) do
    if first in 0..9 do
      do_compact(rest, numbers ++ [first], dots)
    else
      {last, new_rest} = List.pop_at(rest, -1)

      if last == @dot do
        do_compact([first | new_rest], numbers, dots ++ [last])
      else
        do_compact(new_rest, numbers ++ [last], dots ++ [@dot])
      end
    end
  end

  def filesystem_checksum(compacted_blocks) when is_binary(compacted_blocks) do
    Regex.scan(~r/\d/, compacted_blocks)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> filesystem_checksum()
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
