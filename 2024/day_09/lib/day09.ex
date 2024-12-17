defmodule Day09 do
  def part1(path) do
    process(path)
  end

  def id(disk_map) do
    String.split(disk_map, "", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(fn n, i ->
      {i, n}

      d = if Integer.mod(i, 2) == 1, do: ".", else: i
      Stream.repeatedly(fn -> d end) |> Enum.take(n) |> Enum.join()
    end)

    %{files: files, free_space: _free_space} =
      String.split(disk_map, "", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.group_by(fn {_n, i} -> if Integer.mod(i, 2) == 0, do: :files, else: :free_space end)

    Enum.map(files, fn {file_block, file_index} ->
      [
        Stream.repeatedly(fn -> file_index end) |> Enum.take(file_block) |> Enum.join()
      ]
    end)
  end

  def process(path) do
    File.read!(path) |> String.trim()
  end
end
