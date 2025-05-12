require 'faker'

puts "🌱 Creating users"

User.create!(
  email: 'super_admin@example.com',
  password: 'password123',
  username: 'admin',
  role: :super_admin,
  confirmed_at: Time.current
)
puts "-- Created super admin user"

User.roles.keys.each do |role|
  10.times do |i|
    User.create!(
      email: Faker::Internet.email,
      password: 'password123',
      username: "username_#{role}_#{i}",
      role: role,
      confirmed_at: Time.current
    )

    puts "-- Created #{role} ##{i}"
  end
end
puts "✅ Created #{User.count} users in total"
