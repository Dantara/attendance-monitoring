defmodule AttendanceAppWeb.PageController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Repo

  def index(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload(:role)

    redirect_path =
      "/#{current_user.role.title}/"
      |> String.downcase

    redirect(conn, to: redirect_path)
  end
end
