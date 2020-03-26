defmodule AttendanceAppWeb.ActivityControllerTest do
  use AttendanceAppWeb.ConnCase

  alias AttendanceApp.Attendance
  alias AttendanceApp.Attendance.Activity

  # @create_attrs %{
  #   title: "some title"
  # }
  # @update_attrs %{
  #   title: "some updated title"
  # }
  # @invalid_attrs %{title: nil}

  # def fixture(:activity) do
  #   {:ok, activity} = Attendance.create_activity(@create_attrs)
  #   activity
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all activities", %{conn: conn} do
  #     conn = get(conn, Routes.activity_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create activity" do
  #   test "renders activity when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.activity_path(conn, :create), activity: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.activity_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "title" => "some title"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.activity_path(conn, :create), activity: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update activity" do
  #   setup [:create_activity]

  #   test "renders activity when data is valid", %{conn: conn, activity: %Activity{id: id} = activity} do
  #     conn = put(conn, Routes.activity_path(conn, :update, activity), activity: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.activity_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "title" => "some updated title"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, activity: activity} do
  #     conn = put(conn, Routes.activity_path(conn, :update, activity), activity: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete activity" do
  #   setup [:create_activity]

  #   test "deletes chosen activity", %{conn: conn, activity: activity} do
  #     conn = delete(conn, Routes.activity_path(conn, :delete, activity))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.activity_path(conn, :show, activity))
  #     end
  #   end
  # end

  # defp create_activity(_) do
  #   activity = fixture(:activity)
  #   {:ok, activity: activity}
  # end
end
