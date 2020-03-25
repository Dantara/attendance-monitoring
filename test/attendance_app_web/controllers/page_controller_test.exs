defmodule AttendanceAppWeb.PageControllerTest do
  use AttendanceAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end
end
