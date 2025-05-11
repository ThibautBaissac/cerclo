class CreateGroupSessions < ActiveRecord::Migration[8.1]
  def change
    create_table(:group_sessions) do |t|
      t.references(:group, null: false, foreign_key: true)
      t.datetime(:starts_at, null: false)
      t.integer(:duration, null: false, default: 60)

      t.timestamps
    end
  end
end
