class AddTopicToGroup < ActiveRecord::Migration[8.1]
  def change
    add_reference(:groups, :topic, null: false, foreign_key: true)
  end
end
