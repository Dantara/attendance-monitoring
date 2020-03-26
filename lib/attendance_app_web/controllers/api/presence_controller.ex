defmodule AttendanceAppWeb.API.PresenceController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Attendance
  alias AttendanceApp.Attendance.Presence

  action_fallback AttendanceAppWeb.FallbackController

  def index(conn, _params) do
    presences = Attendance.list_presences()
    render(conn, "index.json", presences: presences)
  end

  def create(conn, %{"presence" => presence_params}) do
    with {:ok, %Presence{} = presence} <- Attendance.create_presence(presence_params) do
      presence = Attendance.get_presence!(presence.id)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.presence_path(conn, :show, presence))
      |> render("show.json", presence: presence)
    end
  end

  def show(conn, %{"id" => id}) do
    presence = Attendance.get_presence!(id)

    IO.inspect presence
    render(conn, "show.json", presence: presence)
  end

  def update(conn, %{"id" => id, "presence" => presence_params}) do
    presence = Attendance.get_presence!(id)

    with {:ok, %Presence{} = presence} <- Attendance.update_presence(presence, presence_params) do
      render(conn, "show.json", presence: presence)
    end
  end

  def delete(conn, %{"id" => id}) do
    presence = Attendance.get_presence!(id)

    with {:ok, %Presence{}} <- Attendance.delete_presence(presence) do
      send_resp(conn, :no_content, "")
    end
  end

  def user_presences(conn, _params) do
    current_user = Pow.Plug.current_user(conn)

    presences = Attendance.user_presences(current_user)
    render(conn, "index.json", presences: presences)
  end
end
