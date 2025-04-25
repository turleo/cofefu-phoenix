defmodule Coffeefu.Auth.Role do
  @moduledoc """
  A role is a role of the application.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string

    many_to_many :users, Coffeefu.Auth.User, join_through: "user_roles"
    has_many :roles_permissions, Coffeefu.Auth.RolePermission, foreign_key: :role_id
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :permissions])
    |> validate_required([:name, :permissions])
  end
end
