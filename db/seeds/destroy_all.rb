puts "Starting to empty the database..."

models = [
  User,
  User::Profile,
  Topic,
  Group::Member,
  Group::Session,
  Group
]

ActiveRecord::Base.transaction do
  models.each do |model|
    if model.table_exists?
      puts "Destroying all records of #{model.name}..."
      model.destroy_all
    else
      puts "Skipping #{model.name} as the table does not exist."
    end
  end
end

puts "✅ All tables have been emptied successfully."
