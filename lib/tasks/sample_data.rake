namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(username: "groups",
                 email: "groups@wegroup.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)             
    99.times do |n|
      username  = Faker::Name.name
      email = "member-#{n+1}@wegroup.com"
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentences(4)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end