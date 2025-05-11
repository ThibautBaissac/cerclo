class CreateTopics < ActiveRecord::Migration[8.1]
  def change
    create_table(:topics) do |t|
      t.string(:name, null: false)
      t.integer(:category, null: false, default: 0)

      t.timestamps
    end

    add_index(:topics, :name, unique: true)
    add_index(:topics, :category)
  end
end
