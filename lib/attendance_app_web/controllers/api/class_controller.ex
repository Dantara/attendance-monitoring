defmodule AttendanceAppWeb.API.ClassController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Attendance
  alias AttendanceApp.Accounts
  alias AttendanceApp.Attendance.Class
  alias AttendanceApp.Repo

  action_fallback AttendanceAppWeb.FallbackController

  def index(conn, _params) do
    classes = Attendance.list_classes()
    render(conn, "index.json", classes: classes)
  end

  def create(conn, %{"class" => class_params}) do
    with {:ok, %Class{} = class} <- Attendance.create_class(class_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.class_path(conn, :show, class))
      |> render("show.json", class: class)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Attendance.get_class!(id)
    render(conn, "show.json", class: class)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Attendance.get_class!(id)

    with {:ok, %Class{} = class} <- Attendance.update_class(class, class_params) do
      render(conn, "show.json", class: class)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Attendance.get_class!(id)

    with {:ok, %Class{}} <- Attendance.delete_class(class) do
      send_resp(conn, :no_content, "")
    end
  end

  def user_classes(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload([:role, :classes])

    %{classes: classes} = current_user
    render(conn, "index.json", classes: classes)
  end
end
