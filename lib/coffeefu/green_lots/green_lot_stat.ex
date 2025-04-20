defmodule Coffeefu.GreenLotStat do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:lot_number, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :lot_number}
  schema "green_lot_stats" do
    field :humidity, :decimal
    field :aw, :decimal
    field :density, :integer

    belongs_to :green_lot, Coffeefu.GreenLot,
      references: :lot_number,
      define_field: false,
      type: :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(green_lot_stat, attrs) do
    green_lot_stat
    |> cast(attrs, [:lot_number, :humidity, :aw, :density])
    |> validate_required([:lot_number, :humidity, :aw, :density])
    |> unique_constraint(:lot_number)
    |> foreign_key_constraint(:lot_number)
  end
end
