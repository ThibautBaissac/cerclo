require 'faker'

puts "🌱 Creating groups"

group_count = 0
total_group_count = 10

total_group_count.times do
  Group.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    subtitle: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    min_participants: rand(2..5),
    max_participants: rand(5..10),
    topic: Topic.all.sample
  )
  group_count += 1
  puts "-- Created group #{group_count}/#{total_group_count}: #{Group.last.title}"
end
puts "✅ Created #{total_group_count} groups in total"
