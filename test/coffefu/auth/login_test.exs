defmodule Coffeefu.Auth.LoginTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Coffeefu.Auth.Repo)
  end

  test "login user" do
    email = Faker.Internet.email()
    password = "password"
    assert {:ok, user} = Coffeefu.Auth.Repo.register_user(%{email: email, password: password})

    assert {:ok, access_token, refresh_token} = Coffeefu.Auth.Repo.generate_access_token(user)
    assert {:ok, user} = Coffeefu.Auth.Repo.get_user_by_access_token(access_token)
    assert user.email == email
    assert {:ok, access_token, _refresh_token} = Coffeefu.Auth.Repo.update_access_token(refresh_token)
    assert {:ok, user} = Coffeefu.Auth.Repo.get_user_by_access_token(access_token)
    assert user.email == email
  end
end
