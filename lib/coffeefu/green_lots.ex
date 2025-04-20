defmodule Coffeefu.GreenLots do
  @moduledoc """
  The Green context.
  """

  import Ecto.Query, warn: false
  alias Coffeefu.Repo

  alias Coffeefu.{
    Location,
    ProcessingMethod,
    GreenLot,
    GreenLotStat
  }

  # ---------------------
  # Locations
  # ---------------------

  def list_locations, do: Repo.all(Location)

  def get_location!(id), do: Repo.get!(Location, id)

  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  def delete_location(%Location{} = location), do: Repo.delete(location)

  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end

  # ---------------------
  # Processing Methods
  # ---------------------

  def list_processing_methods, do: Repo.all(ProcessingMethod)

  def get_processing_method!(id), do: Repo.get!(ProcessingMethod, id)

  def create_processing_method(attrs \\ %{}) do
    %ProcessingMethod{}
    |> ProcessingMethod.changeset(attrs)
    |> Repo.insert()
  end

  def update_processing_method(%ProcessingMethod{} = method, attrs) do
    method
    |> ProcessingMethod.changeset(attrs)
    |> Repo.update()
  end

  def delete_processing_method(%ProcessingMethod{} = method), do: Repo.delete(method)

  def change_processing_method(%ProcessingMethod{} = method, attrs \\ %{}) do
    ProcessingMethod.changeset(method, attrs)
  end

  # ---------------------
  # Green Lots
  # ---------------------

  def list_green_lots, do: Repo.all(GreenLot)

  def get_green_lot!(lot_number), do: Repo.get!(GreenLot, lot_number)

  def create_green_lot(attrs \\ %{}) do
    %GreenLot{}
    |> GreenLot.changeset(attrs)
    |> Repo.insert()
  end

  def update_green_lot(%GreenLot{} = lot, attrs) do
    lot
    |> GreenLot.changeset(attrs)
    |> Repo.update()
  end

  def delete_green_lot(%GreenLot{} = lot), do: Repo.delete(lot)

  def change_green_lot(%GreenLot{} = lot, attrs \\ %{}) do
    GreenLot.changeset(lot, attrs)
  end

  # ---------------------
  # Green Lot Stats
  # ---------------------

  def list_green_lot_stats, do: Repo.all(GreenLotStat)

  def get_green_lot_stat!(lot_number), do: Repo.get!(GreenLotStat, lot_number)

  def create_green_lot_stat(attrs \\ %{}) do
    %GreenLotStat{}
    |> GreenLotStat.changeset(attrs)
    |> Repo.insert()
  end

  def update_green_lot_stat(%GreenLotStat{} = stat, attrs) do
    stat
    |> GreenLotStat.changeset(attrs)
    |> Repo.update()
  end

  def delete_green_lot_stat(%GreenLotStat{} = stat), do: Repo.delete(stat)

  def change_green_lot_stat(%GreenLotStat{} = stat, attrs \\ %{}) do
    GreenLotStat.changeset(stat, attrs)
  end
end
