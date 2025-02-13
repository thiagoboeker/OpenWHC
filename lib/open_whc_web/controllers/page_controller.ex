defmodule OpenWhcWeb.PageController do
  use OpenWhcWeb, :controller

  alias OpenWhc.WhcSites

  @doc """
  We are using a fully powered HTML view so we remove the dependencie of the root layout using put_root_layout/2
  """
  def home(conn, _params) do
    conn
    |> put_root_layout(false)
    |> render(:home, layout: false)
  end

  def index(conn, _params) do
    data = WhcSites.data()

    conn
    |> put_resp_content_type("application/json")
    # We dont need to use a view, our data is already well formatted
    |> send_resp(200, Jason.encode!(%{data: data}))
  end
end
