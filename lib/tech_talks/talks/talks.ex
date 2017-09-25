defmodule TechTalks.Talks do
  @moduledoc """
  The Talks context.
  """

  import Ecto.Query, warn: false
  use Timex
  alias TechTalks.Repo

  alias TechTalks.Talks.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  def unused_requested_topics do
    Repo.all(
      from t in Topic,
        select: t.name,
        where: not t.used
    )
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(hash) when is_map(hash), do: Repo.get_by(Topic, hash)
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(nil, attrs), do: nil
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  alias TechTalks.Talks.Talk

  @doc """
  Returns the list of talks.

  ## Examples

      iex> list_talks()
      [%Talk{}, ...]

  """
  def list_talks do
    Repo.all(Talk)
  end

  def list_upcomming_talks do
    Repo.all(future_talks)
  end

  defp future_talks do
    from t in Talk,
      where: t.date >= ^DateTime.utc_now
  end

  @doc """
  Gets a single talk.

  Raises `Ecto.NoResultsError` if the Talk does not exist.

  ## Examples

      iex> get_talk!(123)
      %Talk{}

      iex> get_talk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_talk!(id), do: Repo.get!(Talk, id)

  @doc """
  Creates a talk.

  ## Examples

      iex> create_talk(%{field: value})
      {:ok, %Talk{}}

      iex> create_talk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  defp create_new_talk(attrs \\ %{}) do
    %Talk{}
    |> Talk.changeset(Map.put(attrs, "date", format_date(attrs["date"])))
    |> Repo.insert()
  end

  def create_talk(attrs \\ %{}) do
    # todo: figure out how to use Ecto.Multi
    TechTalks.Repo.transaction(fn ->
      get_topic!(%{name: attrs["topic"]})
      |> update_topic(%{used: true})
      case create_new_talk(attrs) do
        {:ok, any} ->
          any
        {:error, any} ->
          TechTalks.Repo.rollback(any)
          {:error, any}
      end
    end)
  end

  defp format_date(""), do: ""
  defp format_date(date) do
    date <> "T00:00:00Z"
    |> Timex.parse!("{ISO:Extended:Z}")
  end

  @doc """
  Updates a talk.

  ## Examples

      iex> update_talk(talk, %{field: new_value})
      {:ok, %Talk{}}

      iex> update_talk(talk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_talk(%Talk{} = talk, attrs) do
    talk
    |> Talk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Talk.

  ## Examples

      iex> delete_talk(talk)
      {:ok, %Talk{}}

      iex> delete_talk(talk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_talk(%Talk{} = talk) do
    Repo.delete(talk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking talk changes.

  ## Examples

      iex> change_talk(talk)
      %Ecto.Changeset{source: %Talk{}}

  """
  def change_talk(%Talk{} = talk) do
    Talk.changeset(talk, %{})
  end
end
