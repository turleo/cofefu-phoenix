defmodule Coffeefu.GreenLot do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:lot_number, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :lot_number}
  schema "green_lots" do
    field :harvest_date, :date

    belongs_to :location, Coffeefu.Location, type: Ecto.UUID
    belongs_to :processing_method, Coffeefu.ProcessingMethod, type: Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(green_lot, attrs) do
    green_lot
    |> cast(attrs, [:lot_number, :harvest_date, :location_id, :processing_method_id])
    |> validate_required([:lot_number, :harvest_date, :location_id, :processing_method_id])
    |> unique_constraint(:lot_number)
    |> foreign_key_constraint(:location_id)
    |> foreign_key_constraint(:processing_method_id)
  end
end
