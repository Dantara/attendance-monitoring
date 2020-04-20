defmodule AttendanceAppWeb.RegistrationController do
  use AttendanceAppWeb, :controller
  alias AttendanceApp.Accounts
  alias AttendanceApp.Accounts.User
  alias AttendanceApp.Repo

  def new(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    roles = Accounts.roles_without_admin

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
           render(conn, "new.html", changeset: changeset, role: roles)
       end
  end

  def new_admin(conn, _params) do
    changeset = %User{} |> User.changeset(%{})

    render(conn, "new_admin.html", changeset: changeset)
  end

  def create_admin(conn, %{"user" => params}) do
    admin_role = Accounts.get_admin_role

    user_params = Map.merge(params, %{"role_id" => admin_role.id})

    User.changeset(%User{}, user_params)
    |> Repo.insert
    |> case do
         {:ok, user} ->
           conn
           |> put_flash(:info, "Account successfully created!")
           |> redirect(to: "/administrator/registration")

         {:error, changeset} ->
           render(conn, "new_admin.html", changeset: changeset)
       end
  end
end
