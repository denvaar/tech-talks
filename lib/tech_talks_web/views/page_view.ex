defmodule TechTalksWeb.PageView do
  use TechTalksWeb, :view
  use Timex

  def date_format(date), do: date_format(date, "%b %d, %Y")
  def date_format(date, format_string) do
    date
    |> date_formatter(format_string)
  end

  defp date_formatter(date, format_string) do
    date
    |> Timex.format!(format_string, :strftime)
  end
end
