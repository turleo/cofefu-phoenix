defmodule Coffeefu.Repo.Migrations.CreateAuth do
  use Ecto.Migration
  def change do
    create table(:roles) do
      add :name, :string, null: false
    end

    create table(:roles_permissions) do
      add :role_id, references(:roles, on_delete: :delete_all), null: false, primary_key: true
      add :permission, :string, values: [:grade, :give_feedback, :manage_green_lots, :manage_lots, :manage_roasters, :manage_orders], null: false
    end
    create unique_index(:roles_permissions, [:role_id, :permission])

    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string, null: false
    end
    create unique_index(:users, [:email])

    create table(:employee_profiles) do
      add :user_id, references(:users, on_delete: :delete_all), null: false, primary_key: true
      add :name, :string, null: false
      add :surname, :string, null: false
      add :father_name, :string, null: false
    end

    create table(:user_roles) do
      add :user_id, references(:users, on_delete: :delete_all), null: false, primary_key: true
      add :role_id, references(:roles, on_delete: :delete_all), null: false, primary_key: true
    end
    create unique_index(:user_roles, [:user_id, :role_id])
  end
end
