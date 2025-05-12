class CreateUserProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table(:user_profiles) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.string(:firstname, null: false)
      t.string(:lastname, null: false)
      t.text(:bio)
      t.string(:short_bio)
      t.string(:job)

      t.timestamps
    end
  end
end
