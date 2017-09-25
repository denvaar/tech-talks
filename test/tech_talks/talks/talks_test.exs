defmodule TechTalks.TalksTest do
  use TechTalks.DataCase

  alias TechTalks.Talks

  describe "topics" do
    alias TechTalks.Talks.Topic

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Talks.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Talks.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Talks.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Talks.create_topic(@valid_attrs)
      assert topic.description == "some description"
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Talks.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Talks.update_topic(topic, @update_attrs)
      assert %Topic{} = topic
      assert topic.description == "some updated description"
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Talks.update_topic(topic, @invalid_attrs)
      assert topic == Talks.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Talks.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Talks.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Talks.change_topic(topic)
    end
  end

  describe "talks" do
    alias TechTalks.Talks.Talk

    @valid_attrs %{date: "2010-04-17 14:00:00.000000Z", description: "some description", estimated_duration: "some estimated_duration", presenter: "some presenter", topic: "some topic"}
    @update_attrs %{date: "2011-05-18 15:01:01.000000Z", description: "some updated description", estimated_duration: "some updated estimated_duration", presenter: "some updated presenter", topic: "some updated topic"}
    @invalid_attrs %{date: nil, description: nil, estimated_duration: nil, presenter: nil, topic: nil}

    def talk_fixture(attrs \\ %{}) do
      {:ok, talk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Talks.create_talk()

      talk
    end

    test "list_talks/0 returns all talks" do
      talk = talk_fixture()
      assert Talks.list_talks() == [talk]
    end

    test "get_talk!/1 returns the talk with given id" do
      talk = talk_fixture()
      assert Talks.get_talk!(talk.id) == talk
    end

    test "create_talk/1 with valid data creates a talk" do
      assert {:ok, %Talk{} = talk} = Talks.create_talk(@valid_attrs)
      assert talk.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert talk.description == "some description"
      assert talk.estimated_duration == "some estimated_duration"
      assert talk.presenter == "some presenter"
      assert talk.topic == "some topic"
    end

    test "create_talk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Talks.create_talk(@invalid_attrs)
    end

    test "update_talk/2 with valid data updates the talk" do
      talk = talk_fixture()
      assert {:ok, talk} = Talks.update_talk(talk, @update_attrs)
      assert %Talk{} = talk
      assert talk.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert talk.description == "some updated description"
      assert talk.estimated_duration == "some updated estimated_duration"
      assert talk.presenter == "some updated presenter"
      assert talk.topic == "some updated topic"
    end

    test "update_talk/2 with invalid data returns error changeset" do
      talk = talk_fixture()
      assert {:error, %Ecto.Changeset{}} = Talks.update_talk(talk, @invalid_attrs)
      assert talk == Talks.get_talk!(talk.id)
    end

    test "delete_talk/1 deletes the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{}} = Talks.delete_talk(talk)
      assert_raise Ecto.NoResultsError, fn -> Talks.get_talk!(talk.id) end
    end

    test "change_talk/1 returns a talk changeset" do
      talk = talk_fixture()
      assert %Ecto.Changeset{} = Talks.change_talk(talk)
    end
  end
end
