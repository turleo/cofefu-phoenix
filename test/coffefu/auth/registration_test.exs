defmodule Coffeefu.Auth.RegistrationTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Coffeefu.Auth.Repo)
  end

  test "register user" do
    email = Faker.Internet.email()
    password = "password"
    assert {:ok, user} = Coffeefu.Auth.Repo.register_user(%{email: email, password: password})
    assert user.email == email
    assert user.password_hash

    user = Coffeefu.Auth.Repo.preload(user, [:roles, :employee_profile])
    assert user.roles == []
    assert user.employee_profile == nil
  end

  test "register user with duplicated email" do
    email = Faker.Internet.email()
    password = "password"
    assert {:ok, _user} = Coffeefu.Auth.Repo.register_user(%{email: email, password: password})
    assert_raise Ecto.ConstraintError, fn ->
      Coffeefu.Auth.Repo.register_user(%{email: email, password: password})
    end
  end

end
