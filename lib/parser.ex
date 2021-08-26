defmodule GenReport.Parser do
  @months %{
    "1" => "Janeiro",
    "2" => "Fevereiro",
    "3" => "Março",
    "4" => "Abril",
    "5" => "Maio",
    "6" => "Junho",
    "7" => "Julho",
    "8" => "Agosto",
    "9" => "Setembro",
    "10" => "Outubro",
    "11" => "Novembro",
    "12" => "Dezembro"
  }

  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
    |> List.update_at(4, &String.to_integer/1)
    |> get_month_name()

    # |> generate_line_map()
  end

  defp get_month_name(line) do
    line
    |> List.update_at(3, &@months[&1])
  end
end
