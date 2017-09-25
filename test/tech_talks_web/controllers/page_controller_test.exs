defmodule TechTalksWeb.PageControllerTest do
  use TechTalksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Decisely Tech Talks"
  end
end
