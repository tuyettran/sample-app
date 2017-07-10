User.create! name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  is_admin: true,
  is_activated: true,
  activated_at: Time.zone.now

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_activated: true,
    activated_at: Time.zone.now
end

users = User.order(:created_at).take 6

10.times do
  content = Faker::Lorem.sentence 5
  users.each{|user| user.microposts.create! content: content}
end

users = User.all
user = users.first
following = users[2..15]
followers = users[3..20]
following.each{|followed| user.follow followed}
followers.each{|follower| follower.follow user}
