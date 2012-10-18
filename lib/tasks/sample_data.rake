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
  end
end
