require 'faker'

puts "🌱 Creating group sessions"

Group.all.each do |group|
  num_sessions = rand(1..10)

  num_sessions.times do
    group.group_sessions.create!(
      starts_at: Faker::Time.forward(days: 23, period: :morning),
      duration: rand(Group::Session::MIN_DURATION..Group::Session::MAX_DURATION)
    )
  end
  puts "-- Created sessions for group #{group.title}"
end
puts "✅ Created #{Group::Session.count} sessions in total"
