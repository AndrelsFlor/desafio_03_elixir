defmodule GenReport do
  @months [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ]

  @years [2016, 2017, 2018, 2019, 2020]

  @names [
    "Cleiton",
    "Daniele",
    "Danilo",
    "Diego",
    "Giuliano",
    "Jakeliny",
    "Joseph",
    "Mayk",
    "Rafael",
    "Vinicius"
  ]
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    # |> Enum.map(& &1)
    |> Enum.reduce(zeroed_reports(), fn line, report -> sum_hours(line, report) end)
  end

  defp sum_hours(line, report) do
    [name, hours, _month_day, _month_name, _year] = line
    %{"all_hours" => all_hours} = report
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)
    %{"all_hours" => all_hours}
  end

  defp zeroed_reports() do
    all_hours = Enum.into(@names, %{}, &{&1, 0})

    hours_per_month =
      Enum.into(@names, %{}, fn name -> {name, Enum.into(@months, %{}, &{&1, 0})} end)

    hours_per_year =
      Enum.into(@names, %{}, fn name -> {name, Enum.into(@years, %{}, &{&1, 0})} end)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
