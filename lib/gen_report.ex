defmodule GenReport do
  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @years [2016, 2017, 2018, 2019, 2020]

  @names [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    # |> Enum.map(& &1)
    |> Enum.reduce(zeroed_reports(), fn line, report -> sum_hours(line, report) end)
  end

  def build do
    {:error, "Insira o nome de um arquivo"}
  end

  defp sum_hours(line, report) do
    [name, hours, _month_day, month_name, year] = line

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    } = report

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month =
      put_in(hours_per_month, [name, month_name], hours_per_month[name][month_name] + hours)

    hours_per_year = put_in(hours_per_year, [name, year], hours_per_year[name][year] + hours)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
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
