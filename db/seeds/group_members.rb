require 'faker'

puts "🌱 Creating members (participants and facilitators)"

Group.all.each do |group|
  group.members.create!(
    user: User.member.sample,
    status: Group::Member.statuses.keys.sample
  )
  group.members.create!(
    user: User.facilitator.sample,
    status: Group::Member.statuses.keys.sample
  )
  puts "Created members for group #{group.title}"
end
puts "✅ Created #{Group::Member.count} members in total"
