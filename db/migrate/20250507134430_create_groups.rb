class CreateGroups < ActiveRecord::Migration[8.1]
  def change
    create_table(:groups) do |t|
      t.string(:uuid, null: false)
      t.string(:title, null: false)
      t.string(:subtitle)
      t.text(:description, null: false)
      t.integer(:min_participants, null: false, default: 2)
      t.integer(:max_participants, null: false, default: 10)
      t.bigint(:facilitator_id, null: false)
      t.integer(:duration, null: false, default: 60)
      t.integer(:frequency, null: false, default: 0)

      t.timestamps
    end

    add_index(:groups, :uuid, unique: true)
    add_index(:groups, :facilitator_id)
  end
end
