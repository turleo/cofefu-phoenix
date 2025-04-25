defmodule Coffeefu.Auth.UserRole do
  @moduledoc """
  A user role is a role that a user has.
  """
  use Ecto.Schema

  schema "user_roles" do
    belongs_to :user, Coffeefu.Auth.User, foreign_key: :user_id
    belongs_to :roles, Coffeefu.Auth.Role, foreign_key: :role_id
  end
end
