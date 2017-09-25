defmodule TechTalksWeb.AboutControllerTest do
  use TechTalksWeb.ConnCase

  test "GET /about", %{conn: conn} do
    conn = get conn, "/about"
    assert html_response(conn, 200) =~ "About"
  end
end
