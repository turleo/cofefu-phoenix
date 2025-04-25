defmodule Coffeefu.Auth.Repo do
  use Ecto.Repo,
    otp_app: :coffeefu,
    adapter: Ecto.Adapters.Postgres

  alias Coffeefu.Auth.Repo
  alias Coffeefu.Auth.{EmployeeProfile, Role, RolePermission, User, UserRole}

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
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

  def generate_access_token(user) do
    access_token = Phoenix.Token.sign(CoffeefuWeb.Endpoint, "user_id", user.id)
    refresh_token = Phoenix.Token.sign(CoffeefuWeb.Endpoint, "user_id", user.id, max_age: 60 * 60 * 24 * 30)
    {:ok, access_token, refresh_token}
  end

  def get_user_by_access_token(token) do
    {:ok, user_id} = Phoenix.Token.verify(CoffeefuWeb.Endpoint, "user_id", token)
    user = Repo.get!(User, user_id)
    {:ok, user}
  end

  def update_access_token(refresh_token) do
    {:ok, user_id} = Phoenix.Token.verify(CoffeefuWeb.Endpoint, "user_id", refresh_token)
    user = Repo.get!(User, user_id)
    {:ok, access_token, refresh_token} = generate_access_token(user)
    {:ok, access_token, refresh_token}
  end

end
