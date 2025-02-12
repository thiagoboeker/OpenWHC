defmodule OpenWhcWeb.ErrorJSONTest do
  use OpenWhcWeb.ConnCase, async: true

  test "renders 404" do
    assert OpenWhcWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert OpenWhcWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
