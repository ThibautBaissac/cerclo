require 'faker'

puts "🌱 Creating facilitator topics"

User.facilitator.each do |facilitator|
  num_topics = rand(1..3)
  topics = Topic.all.sample(num_topics)
  topics.each do |topic|
    FacilitatorTopic.create!(
      user: facilitator,
      topic: topic
    )
  end
  puts "-- Created #{num_topics} topics for facilitator #{facilitator.fullname}"
end
puts "✅ Created facilitator topics"
