defmodule Lecture8 do

  def recursive_count(sent) do
    cond  do
      empty?(sent) -> 0
      true -> 1 + recursive_count(but_first(sent))
    end
  end

  def iterative_count(sent) do
    iter(sent, 0)
  end

  defp iter(sent, acc) do
    cond do
      empty?(sent) -> acc
      true -> iter(but_first(sent), acc + 1)
    end
  end


  def but_first(sentence) do
    sentence
    |> String.split()
    |> tl()
    |> Enum.join(" ")
  end

  def empty?(sentence) do
    String.trim(sentence) == ""
  end
end

phrase = Lecture8.recursive_count("I wanna hold your hand")
phrase2 = Lecture8.iterative_count("I wanna hold your hand")
IO.inspect(phrase)
IO.inspect(phrase2)
