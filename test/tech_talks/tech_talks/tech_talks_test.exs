defmodule TechTalks.TechTalksTest do
  use TechTalks.DataCase

  alias TechTalks.TechTalks

  describe "talks" do
    alias TechTalks.TechTalks.Talk

    @valid_attrs %{date: "2010-04-17 14:00:00.000000Z", description: "some description", estimated_duration: "some estimated_duration", presenter: "some presenter", topic: "some topic"}
    @update_attrs %{date: "2011-05-18 15:01:01.000000Z", description: "some updated description", estimated_duration: "some updated estimated_duration", presenter: "some updated presenter", topic: "some updated topic"}
    @invalid_attrs %{date: nil, description: nil, estimated_duration: nil, presenter: nil, topic: nil}

    def talk_fixture(attrs \\ %{}) do
      {:ok, talk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TechTalks.create_talk()

      talk
    end

    test "list_talks/0 returns all talks" do
      talk = talk_fixture()
      assert TechTalks.list_talks() == [talk]
    end

    test "get_talk!/1 returns the talk with given id" do
      talk = talk_fixture()
      assert TechTalks.get_talk!(talk.id) == talk
    end

    test "create_talk/1 with valid data creates a talk" do
      assert {:ok, %Talk{} = talk} = TechTalks.create_talk(@valid_attrs)
      assert talk.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert talk.description == "some description"
      assert talk.estimated_duration == "some estimated_duration"
      assert talk.presenter == "some presenter"
      assert talk.topic == "some topic"
    end

    test "create_talk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TechTalks.create_talk(@invalid_attrs)
    end

    test "update_talk/2 with valid data updates the talk" do
      talk = talk_fixture()
      assert {:ok, talk} = TechTalks.update_talk(talk, @update_attrs)
      assert %Talk{} = talk
      assert talk.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert talk.description == "some updated description"
      assert talk.estimated_duration == "some updated estimated_duration"
      assert talk.presenter == "some updated presenter"
      assert talk.topic == "some updated topic"
    end

    test "update_talk/2 with invalid data returns error changeset" do
      talk = talk_fixture()
      assert {:error, %Ecto.Changeset{}} = TechTalks.update_talk(talk, @invalid_attrs)
      assert talk == TechTalks.get_talk!(talk.id)
    end

    test "delete_talk/1 deletes the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{}} = TechTalks.delete_talk(talk)
      assert_raise Ecto.NoResultsError, fn -> TechTalks.get_talk!(talk.id) end
    end

    test "change_talk/1 returns a talk changeset" do
      talk = talk_fixture()
      assert %Ecto.Changeset{} = TechTalks.change_talk(talk)
    end
  end
end
