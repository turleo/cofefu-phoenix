defmodule Coffeefu.Auth.Repo do
  use Ecto.Repo,
    otp_app: :coffeefu,
    adapter: Ecto.Adapters.Postgres

  alias Coffeefu.Auth.Repo
  alias Coffeefu.Auth.{EmployeeProfile, Role, RolePermission, User, UserRole}

  def register_user(attrs) do
    user = %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()

    user
  end

  def check_user_permission(user, permission) do
    user = Repo.preload(user, [:roles])
    roles = Repo.preload(user.roles, [:roles_permissions])
    role_permission = Enum.filter(roles, fn role ->
      Enum.filter(role.roles_permissions, fn
        role_permission -> role_permission.permission == permission
      end) != []
    end)
    length(role_permission) > 0
  end
end
