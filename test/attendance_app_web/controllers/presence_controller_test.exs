defmodule AttendanceAppWeb.PresenceControllerTest do
  use AttendanceAppWeb.ConnCase

  alias AttendanceApp.Attendance
  alias AttendanceApp.Attendance.Presence

  # @create_attrs %{
  #   week: 42
  # }
  # @update_attrs %{
  #   week: 43
  # }
  # @invalid_attrs %{week: nil}

  # def fixture(:presence) do
  #   {:ok, presence} = Attendance.create_presence(@create_attrs)
  #   presence
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all presences", %{conn: conn} do
  #     conn = get(conn, Routes.presence_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create presence" do
  #   test "renders presence when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.presence_path(conn, :create), presence: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.presence_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "week" => 42
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.presence_path(conn, :create), presence: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update presence" do
  #   setup [:create_presence]

  #   test "renders presence when data is valid", %{conn: conn, presence: %Presence{id: id} = presence} do
  #     conn = put(conn, Routes.presence_path(conn, :update, presence), presence: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.presence_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "week" => 43
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, presence: presence} do
  #     conn = put(conn, Routes.presence_path(conn, :update, presence), presence: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete presence" do
  #   setup [:create_presence]

  #   test "deletes chosen presence", %{conn: conn, presence: presence} do
  #     conn = delete(conn, Routes.presence_path(conn, :delete, presence))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.presence_path(conn, :show, presence))
  #     end
  #   end
  # end

  # defp create_presence(_) do
  #   presence = fixture(:presence)
  #   {:ok, presence: presence}
  # end
end
