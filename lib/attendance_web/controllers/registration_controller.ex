defmodule AttendanceWeb.RegistrationController do
  use AttendanceWeb, :controller
  alias Attendance.Accounts

  def new(conn, _params) do
    changeset = Pow.Plug.change_user(conn)
    roles = Accounts.list_roles

    render(conn, "new.html", changeset: changeset, roles: roles)
  end

  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
         {:ok, user, conn} ->
           conn
           |> put_flash(:info, "Welcome!")
           |> redirect(to: "/")

         {:error, changeset, conn} ->
           render(conn, "new.html", changeset: changeset)
       end
  end
end
