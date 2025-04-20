defmodule Coffeefu.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    # Locations Table
    create table(:locations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :country_code, :string, null: false
      add :region, :string, null: false
      add :farm, :string, null: false
      add :farmer, :string, null: false

      timestamps(type: :utc_datetime)
    end

    # Processing Methods Table
    create table(:processing_methods, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:processing_methods, [:name])

    # Green Lots Table
    create table(:green_lots, primary_key: false) do
      add :lot_number, :string, primary_key: true
      add :location_id, references(:locations, type: :uuid, on_delete: :nothing), null: false
      add :processing_method_id, references(:processing_methods, type: :uuid, on_delete: :nothing), null: false
      add :harvest_date, :date, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:green_lots, [:lot_number])

    # Green Lot Stats Table
    create table(:green_lot_stats, primary_key: false) do
      add :lot_number, references(:green_lots, column: :lot_number, type: :string, on_delete: :nothing), primary_key: true
      add :humidity, :decimal, null: false
      add :aw, :decimal, null: false
      add :density, :integer, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:green_lot_stats, [:lot_number])
  end
end
