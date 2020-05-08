defmodule AttendanceAppWeb.PageController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Repo

  def index(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload(:role)

    case current_user do
      %{blocked: true} ->
        redirect(conn, to: "/blocked/")

      _ ->
        redirect_path =
          "/#{current_user.role.title}/"
          |> String.downcase

        redirect(conn, to: redirect_path)
    end
  end
end
