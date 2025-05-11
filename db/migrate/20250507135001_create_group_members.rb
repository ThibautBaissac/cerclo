class CreateGroupMembers < ActiveRecord::Migration[8.1]
  def change
    create_table(:group_members) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.references(:group, null: false, foreign_key: true)
      t.integer(:status, null: false, default: 0)

      t.timestamps
    end
  end
end
