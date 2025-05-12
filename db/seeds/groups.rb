require 'faker'

puts "🌱 Creating groups"

total_group_count = 10

total_group_count.times do |i|
  # Create a new group with randomized attributes
  group = Group.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    subtitle: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    min_participants: rand(2..5),
    max_participants: rand(5..10),
    topic: Topic.all.sample,
    facilitator: User.facilitator.sample,
    duration: rand(Group::MIN_DURATION..Group::MAX_DURATION),
    frequency: Group.frequencies.keys.sample
  )

  puts "-- Created group #{i}/#{total_group_count}: #{group.title}"

  # Add members to the group
  puts "   🧑‍🤝‍🧑 Adding participants to group"

  # Find available users not already in this group
  available_users = User.member.select { |member| group.members.exclude?(member) }

  # Determine how many participants to add (limited by available users)
  num_participants = [
    rand(Group::MIN_PARTICIPANTS_COUNT..Group::MAX_PARTICIPANTS_COUNT),
    available_users.size
  ].min

  # Randomly select and add participants
  available_users.sample(num_participants).each do |participant|
    group.members.create!(
      user: participant,
      status: Group::Member.statuses.keys.sample
    )
  end

  puts "   ✓ Added #{num_participants} participants"
end

puts "✅ Created #{total_group_count} groups in total"
