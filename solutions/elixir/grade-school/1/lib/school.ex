defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type student :: %{grade: pos_integer(), name: String.t()}
  @type school :: list(student)

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    []
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if Enum.find(school, fn entry -> entry.name == name end) do
      {:error, school}
    else
      {:ok, List.insert_at(school, -1, %{name: name, grade: grade})}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> Enum.filter(&(&1.grade == grade))
    |> roster()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort(&student_sort/2)
    |> Enum.map(& &1.name)
  end

  @spec student_sort(student, student) :: boolean
  defp student_sort(a, b) do
    if a.grade == b.grade do
      a.name <= b.name
    else
      a.grade <= b.grade
    end
  end
end
