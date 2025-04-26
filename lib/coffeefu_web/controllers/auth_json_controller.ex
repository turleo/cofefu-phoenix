defmodule CoffeefuWeb.AuthJSONController do
  use CoffeefuWeb, :controller
  alias Coffeefu.Auth.Repo
  alias Coffeefu.Auth.User

  @doc """
  Registers user
  """
  def register(conn, body_params) do
    case Repo.register_user(body_params) do
      {:ok, user} ->
        {:ok, access_token, refresh_token} = Repo.generate_access_token(user)
        json(conn, %{access_token: access_token, refresh_token: refresh_token})

      {:error, changeset} ->
        Logger.warning("Invalid registration data: #{inspect(changeset)}")
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid registration data"})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})

      user ->
        if Bcrypt.verify_pass(password, user.password_hash) do
          {:ok, access_token, refresh_token} = Repo.generate_access_token(user)
          json(conn, %{access_token: access_token, refresh_token: refresh_token})
        else
          conn
          |> put_status(:unauthorized)
          |> json(%{error: "Invalid credentials"})
        end
    end
  end

  def refresh_token(conn, %{"refresh_token" => refresh_token}) do
    case Repo.update_access_token(refresh_token) do
      {:ok, access_token, refresh_token} ->
        json(conn, %{access_token: access_token, refresh_token: refresh_token})

      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid refresh token"})
    end
  end
end
