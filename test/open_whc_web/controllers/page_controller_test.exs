defmodule OpenWhcWeb.PageControllerTest do
  use OpenWhcWeb.ConnCase

  alias OpenWhc.WhcSites

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "WHC Explorer"
  end

  test "WHC DATA SOURCE", _ do
    result = WhcSites.data()

    assert length(result) > 0
  end

  test "GET /api/v1/whc_sites", %{conn: conn} do
    conn = get(conn, ~p"/api/v1/whc_sites")
    assert json_response(conn, 200)
  end
end
