require 'faker'

puts "🌱 Creating admin profiles"

admins = User.admin

admins.each do |admin|
  User::Profile.create!(
    user: admin,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name
  )
end

puts "✅ Create admin profiles"
