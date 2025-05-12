class CreateGroupSessions < ActiveRecord::Migration[8.1]
  def change
    create_table(:group_sessions) do |t|
      t.references(:group, null: false, foreign_key: true)
      t.datetime(:starts_at, null: false)

      t.timestamps
    end

    add_index(:group_sessions, [ :group_id, :starts_at ])
  end
end
