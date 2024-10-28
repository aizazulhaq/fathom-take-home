# db/seeds.rb


engineering = Role.find_or_create_by!(role_name: 'Engineering')
sales = Role.find_or_create_by!(role_name: 'Sales')
devops = Role.find_or_create_by!(role_name: 'DevOps')

alice = User.find_or_initialize_by(email: 'alice@example.com')
alice.username = 'alice'
alice.password = 'password123'
alice.password_confirmation = 'password123'
alice.role = engineering
alice.save!

bob = User.find_or_initialize_by(email: 'bob@example.com')
bob.username = 'bob'
bob.password = 'password123'
bob.password_confirmation = 'password123'
bob.role = sales
bob.save!

carol = User.find_or_initialize_by(email: 'carol@example.com')
carol.username = 'carol'
carol.password = 'password123'
carol.password_confirmation = 'password123'
carol.role = devops
carol.save!


RoleAccessPolicy.destroy_all

RoleAccessPolicy.find_or_create_by!(
  creator_role: engineering,
  viewer_role: engineering
)
RoleAccessPolicy.find_or_create_by!(
  creator_role: engineering,
  viewer_role: devops
)

[ engineering, sales, devops ].each do |viewer_role|
  RoleAccessPolicy.find_or_create_by!(
    creator_role: sales,
    viewer_role: viewer_role
  )
end

RoleAccessPolicy.find_or_create_by!(
  creator_role: devops,
  viewer_role: devops
)

number_of_recordings = 10

number_of_recordings.times do
  creator = User.order("RANDOM()").first # Randomly assign a creator from the existing users

  recording = MeetingRecording.new(
    title: Faker::Company.catch_phrase, # Generate a random title
    thumbnail_url: Faker::Internet.url(host: 'example.com', path: "/thumbnails/#{Faker::Number.number(digits: 5)}.jpg"), # Generate a random thumbnail URL
    recording_page_url: Faker::Internet.url(host: 'example.com', path: "/recordings/#{Faker::Number.number(digits: 5)}"), # Generate a random recording page URL
    creator_user: creator,
    creator_role: creator.role
  )
  recording.save!
end
