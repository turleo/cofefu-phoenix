defmodule Coffeefu.Repo do
  use Ecto.Repo,
    otp_app: :coffeefu,
    adapter: Ecto.Adapters.Postgres
end
