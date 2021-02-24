defmodule Rumbl.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, [:password], [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :username], [])
    |> validate_length(:username, min: 1, max: 20)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
