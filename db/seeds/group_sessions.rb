require 'faker'

puts "🌱 Creating group sessions"

Group.all.each_with_index do |group, index|
  # Determine how many sessions to create for this group
  num_sessions = rand(1..10)

  # Create sessions with future start dates
  num_sessions.times do
    group.group_sessions.create!(
      starts_at: Faker::Time.forward(days: 23, period: :morning)
    )
  end
  puts "-- Created #{num_sessions} sessions for group #{index+1}/#{Group.count}: #{group.title}"

  # Add users to each session
  puts "   🧑‍🤝‍🧑 Adding participants to sessions"

  group.group_sessions.each do |session|
    # Find confirmed group members not already in this session
    available_members = group.members.confirmed.select { |member|
      session.participants.exclude?(member.user)
    }

    # Determine how many participants to add (limited by available members)
    num_participants = [
      rand(Group::MAX_PARTICIPANTS_COUNT..Group::MAX_PARTICIPANTS_COUNT),
      available_members.size
    ].min

    # Randomly select and add participants
    available_members.sample(num_participants).map(&:user).each do |participant|
      session.group_session_participants.create!(
        user: participant,
        status: Group::Session::Participant.statuses.keys.sample
      )
    end

    puts "   ✓ Added #{num_participants} participants to session"
  end
end

puts "✅ Created group sessions in total"
