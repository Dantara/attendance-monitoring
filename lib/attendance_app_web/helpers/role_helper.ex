defmodule AttendanceAppWeb.RoleHelper do
  alias AttendanceApp.Accounts

  def create_roles do
    roles = ["Student", "Teacher", "Administrator"]

    Enum.each(roles, fn role -> create_role(role) end)
  end

  defp create_role(title) do
    with {:ok, _} <- Accounts.create_role(%{title: title}) do
      "Role #{title} was created" |> IO.puts
    end
  end

  def delete_roles do
    roles = Accounts.list_roles

    Enum.each(roles, fn role -> Accounts.delete_role(role) end)
  end
end
