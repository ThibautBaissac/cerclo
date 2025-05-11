class AddAttributesToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column(:users, :uuid, :string, null: false)
    add_index(:users, :uuid, unique: true)

    add_column(:users, :username, :string, null: false)
    add_index(:users, :username)

    add_column(:users, :role, :integer, default: 0, null: false)
    add_column(:users, :super_admin, :boolean, default: false, null: false)
  end
end
