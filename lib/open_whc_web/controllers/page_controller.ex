defmodule OpenWhcWeb.PageController do
  use OpenWhcWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
    |> put_root_layout(false)
    |> render(:home, layout: false)
  end
end
