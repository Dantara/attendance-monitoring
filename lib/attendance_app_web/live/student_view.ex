defmodule AttendanceAppWeb.Live.StudentView do
  use Phoenix.LiveView
  alias AttendanceAppWeb.StudentView

  @modes [%{value: "overview", text: "Overview"},
          %{value: "detailed", text: "Detailed view"}]

  def render(assigns) do
    Phoenix.View.render(StudentView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{right_render: "overview.html", modes: @modes, mode: nil})}
  end

  def handle_event("select_mode", %{"mode"  => "overview"}, socket) do
    IO.inspect "overview"
    {:noreply, assign(socket, %{right_render: "overview.html", mode: "overview"})}
  end

  def handle_event("select_mode", %{"mode" => "detailed"}, socket) do
    IO.inspect "detailed"
    {:noreply, assign(socket, %{right_render: "detailed_view.html", mode: "detailed"})}
  end

end
