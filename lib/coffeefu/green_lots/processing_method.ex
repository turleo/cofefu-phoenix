defmodule Coffeefu.ProcessingMethod do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "processing_methods" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(processing_method, attrs) do
    processing_method
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
    |> unique_constraint(:name)
  end
end
