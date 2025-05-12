class CreateFacilitatorTopics < ActiveRecord::Migration[8.1]
  def change
    create_table(:facilitator_topics) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.references(:topic, null: false, foreign_key: true)

      t.timestamps
    end

    add_index(:facilitator_topics, [ :user_id, :topic_id ], unique: true)
  end
end
