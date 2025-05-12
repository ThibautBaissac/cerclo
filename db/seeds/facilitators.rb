require 'faker'

puts "🌱 Creating facilitator profiles"

facilitators = User.facilitator

facilitators.each do |facilitator|
  User::Profile.create!(
    user: facilitator,
    bio: Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4),
    short_bio: Faker::Lorem.paragraph(sentence_count: 1),
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    job: Faker::Job.title
  )
end

puts "✅ Created facilitator profiles"
