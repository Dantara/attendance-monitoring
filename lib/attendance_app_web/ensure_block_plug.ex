defmodule AttendanceAppWeb.EnsureBlockPlug do
  import Plug.Conn, only: [halt: 1]

  alias AttendanceAppWeb.Router.Helpers, as: Routes
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.Plug
  alias AttendanceApp.Repo

  def init(config), do: config

  def call(conn, state) do
    conn
    |> Plug.current_user()
    |> is_state(state)
    |> maybe_halt(conn)
  end

  defp is_state(%{blocked: blocked}, state), do: blocked == state

  defp maybe_halt(true, conn), do: conn
  defp maybe_halt(_any, conn) do
    conn
    |> Controller.put_flash(:error, "Unauthorized access")
    |> Controller.redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end
end
