defmodule AttendanceAppWeb.RegistrationController do
  use AttendanceAppWeb, :controller
  alias AttendanceApp.Accounts

  def new(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    roles = Accounts.list_roles
    # changeset =
    #   %Accounts.User{}
    #   # |> AttendanceApp.Repo.preload(:role)
    #   |> Accounts.User.changeset(%{role: %Accounts.Role{}})

    render(conn, "new.html", changeset: changeset, role: roles)
  end

  def create(conn, %{"user" => user_params}) do
    roles = Accounts.list_roles

    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
         {:ok, user, conn} ->
           conn
           |> put_flash(:info, "Welcome!")
           |> redirect(to: "/")

         {:error, changeset, conn} ->
           IO.inspect changeset
           render(conn, "new.html", changeset: changeset, role: roles)
       end
  end
end
