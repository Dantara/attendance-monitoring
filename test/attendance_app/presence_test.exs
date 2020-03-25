defmodule AttendanceApp.PresenceTest do
  use AttendanceApp.DataCase

  alias AttendanceApp.Presence

  describe "students" do
    alias AttendanceApp.Presence.Student

    @valid_attrs %{class: "some class", email: "some email", first_name: "some first_name", group: "some group", last_name: "some last_name"}
    @update_attrs %{class: "some updated class", email: "some updated email", first_name: "some updated first_name", group: "some updated group", last_name: "some updated last_name"}
    @invalid_attrs %{class: nil, email: nil, first_name: nil, group: nil, last_name: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Presence.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Presence.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Presence.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Presence.create_student(@valid_attrs)
      assert student.class == "some class"
      assert student.email == "some email"
      assert student.first_name == "some first_name"
      assert student.group == "some group"
      assert student.last_name == "some last_name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Presence.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Presence.update_student(student, @update_attrs)
      assert student.class == "some updated class"
      assert student.email == "some updated email"
      assert student.first_name == "some updated first_name"
      assert student.group == "some updated group"
      assert student.last_name == "some updated last_name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Presence.update_student(student, @invalid_attrs)
      assert student == Presence.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Presence.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Presence.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Presence.change_student(student)
    end
  end
end
