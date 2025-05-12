class CreateGroupSessionParticipants < ActiveRecord::Migration[8.1]
  def change
    create_table(:group_session_participants) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.references(:group_session, null: false, foreign_key: true)
      t.integer(:status, null: false, default: 0)

      t.timestamps
    end

    add_index(:group_session_participants, [ :user_id, :group_session_id ], unique: true)
    add_index(:group_session_participants, [ :group_session_id, :status ])
  end
end
