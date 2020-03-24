defmodule AttendanceWeb.RegistrationView do
  use AttendanceWeb, :view

  def parse_roles(initial) do
    Enum.map(initial,
      fn el -> {el.title, el.id} end)
  end
end
