defmodule Coffeefu.Location do
  @moduledoc """
  A location is a physical place where green coffee beans are grown.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "locations" do
    field :country_code, :string
    field :region, :string
    field :farm, :string
    field :farmer, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:id, :country_code, :region, :farm, :farmer])
    |> validate_required([:id, :country_code, :region, :farm, :farmer])
  end
end
