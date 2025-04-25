defmodule Coffeefu.Auth.EmployeeProfile do
  @moduledoc """
  An employee profile is a profile of an employee of the application.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "employee_profiles" do
    belongs_to :user, Coffeefu.Auth.User, [foreign_key: :user_id]
    field :name, :string
    field :surname, :string
    field :father_name, :string
  end

  def changeset(employee_profile, attrs) do
    employee_profile
    |> cast(attrs, [:name, :surname, :father_name, :user_id])
    |> validate_required([:name, :surname, :father_name, :user_id])
  end
end
