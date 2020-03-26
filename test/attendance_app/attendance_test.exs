defmodule AttendanceApp.AttendanceTest do
  use AttendanceApp.DataCase

  alias AttendanceApp.Attendance

  # describe "activities" do
  #   alias AttendanceApp.Attendance.Activity

  #   @valid_attrs %{title: "some title"}
  #   @update_attrs %{title: "some updated title"}
  #   @invalid_attrs %{title: nil}

  #   def activity_fixture(attrs \\ %{}) do
  #     {:ok, activity} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Attendance.create_activity()

  #     activity
  #   end

  #   test "list_activities/0 returns all activities" do
  #     activity = activity_fixture()
  #     assert Attendance.list_activities() == [activity]
  #   end

  #   test "get_activity!/1 returns the activity with given id" do
  #     activity = activity_fixture()
  #     assert Attendance.get_activity!(activity.id) == activity
  #   end

  #   test "create_activity/1 with valid data creates a activity" do
  #     assert {:ok, %Activity{} = activity} = Attendance.create_activity(@valid_attrs)
  #     assert activity.title == "some title"
  #   end

  #   test "create_activity/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Attendance.create_activity(@invalid_attrs)
  #   end

  #   test "update_activity/2 with valid data updates the activity" do
  #     activity = activity_fixture()
  #     assert {:ok, %Activity{} = activity} = Attendance.update_activity(activity, @update_attrs)
  #     assert activity.title == "some updated title"
  #   end

  #   test "update_activity/2 with invalid data returns error changeset" do
  #     activity = activity_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Attendance.update_activity(activity, @invalid_attrs)
  #     assert activity == Attendance.get_activity!(activity.id)
  #   end

  #   test "delete_activity/1 deletes the activity" do
  #     activity = activity_fixture()
  #     assert {:ok, %Activity{}} = Attendance.delete_activity(activity)
  #     assert_raise Ecto.NoResultsError, fn -> Attendance.get_activity!(activity.id) end
  #   end

  #   test "change_activity/1 returns a activity changeset" do
  #     activity = activity_fixture()
  #     assert %Ecto.Changeset{} = Attendance.change_activity(activity)
  #   end
  # end

  # describe "classes" do
  #   alias AttendanceApp.Attendance.Class

  #   @valid_attrs %{title: "some title"}
  #   @update_attrs %{title: "some updated title"}
  #   @invalid_attrs %{title: nil}

  #   def class_fixture(attrs \\ %{}) do
  #     {:ok, class} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Attendance.create_class()

  #     class
  #   end

  #   test "list_classes/0 returns all classes" do
  #     class = class_fixture()
  #     assert Attendance.list_classes() == [class]
  #   end

  #   test "get_class!/1 returns the class with given id" do
  #     class = class_fixture()
  #     assert Attendance.get_class!(class.id) == class
  #   end

  #   test "create_class/1 with valid data creates a class" do
  #     assert {:ok, %Class{} = class} = Attendance.create_class(@valid_attrs)
  #     assert class.title == "some title"
  #   end

  #   test "create_class/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Attendance.create_class(@invalid_attrs)
  #   end

  #   test "update_class/2 with valid data updates the class" do
  #     class = class_fixture()
  #     assert {:ok, %Class{} = class} = Attendance.update_class(class, @update_attrs)
  #     assert class.title == "some updated title"
  #   end

  #   test "update_class/2 with invalid data returns error changeset" do
  #     class = class_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Attendance.update_class(class, @invalid_attrs)
  #     assert class == Attendance.get_class!(class.id)
  #   end

  #   test "delete_class/1 deletes the class" do
  #     class = class_fixture()
  #     assert {:ok, %Class{}} = Attendance.delete_class(class)
  #     assert_raise Ecto.NoResultsError, fn -> Attendance.get_class!(class.id) end
  #   end

  #   test "change_class/1 returns a class changeset" do
  #     class = class_fixture()
  #     assert %Ecto.Changeset{} = Attendance.change_class(class)
  #   end
  # end
end
