defmodule Coffeefu.Auth.CheckPermissionsTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Coffeefu.Auth.Repo)
  end

  test "check user permission" do
    email = Faker.Internet.email()
    password = "password"
    assert {:ok, user} = Coffeefu.Auth.Repo.register_user(%{email: email, password: password})

    assert Coffeefu.Auth.Repo.check_user_permission(user, :manage_green_lots) == false

    assert role = Coffeefu.Auth.Repo.insert!(%Coffeefu.Auth.Role{name: "admin"})
    Coffeefu.Auth.Repo.insert!(%Coffeefu.Auth.RolePermission{role_id: role.id, permission: :manage_green_lots})
    Coffeefu.Auth.Repo.insert!(%Coffeefu.Auth.UserRole{user_id: user.id, role_id: role.id})

    user = Coffeefu.Auth.Repo.reload(user)
    user = Coffeefu.Auth.Repo.preload(user, [:roles])

    assert Coffeefu.Auth.Repo.check_user_permission(user, :manage_green_lots) == true
  end
end
