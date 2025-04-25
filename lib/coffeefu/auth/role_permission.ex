defmodule Coffeefu.Auth.RolePermission do
  @moduledoc """
  A role permission is a permission that a role has.
  """
  use Ecto.Schema

  schema "roles_permissions" do
    field :permission, Ecto.Enum, values: [
      :grade, :give_feedback, :manage_green_lots, :manage_lots, :manage_roasters, :manage_orders
    ]

    belongs_to :roles, Coffeefu.Auth.Role, foreign_key: :role_id
  end
end
