defmodule Rumbl.TestHelpers do
  alias Rumbl.Repo

  def insert_user(attrs \\ []) do
    changes =
      Map.merge(
        %{
          name: "Some User",
          username: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}",
          password: "supersecret"
        },
        Enum.into(attrs, %{})
      )

    %Rumbl.User{}
    |> Rumbl.User.registration_changeset(changes)
    |> Repo.insert()
    |> elem(1)
  end

  def insert_video(user, attrs \\ []) do
    user
    |> Ecto.build_assoc(:videos, Enum.into(attrs, %{}))
    |> Repo.insert()
    |> elem(1)
  end
end
