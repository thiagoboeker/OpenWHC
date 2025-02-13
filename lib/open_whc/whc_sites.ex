defmodule OpenWhc.WhcSites do
  @moduledoc """
  Context Module for the WHC data
  """
  @fields [
    "id_no",
    "name_en",
    "short_description_en",
    "longitude",
    "latitude"
  ]

  @doc """
  Returns the WHC Sites dataset JSON friendly based on the @fields description.
  """
  def data() do
    Path.join(:code.priv_dir(:open_whc), "data/whc-sites.csv")
    |> File.stream!()
    |> CSV.decode(escape_max_lines: 50, headers: true)
    |> Enum.into([])
    |> Enum.map(fn {:ok, el} ->
      el
      |> Enum.flat_map(&parse/1)
      |> Enum.into(%{})
    end)
  end

  # We are wrapping it because we're using flat_map for filtering the fields
  defp parse({field, value}) when field in @fields, do: [{field, value}]
  # Flatmap excludes the item
  defp parse(_), do: []
end
