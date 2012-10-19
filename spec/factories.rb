FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "Member#{n}"}
    sequence(:email) {|n| "member#{n}@wegroup.com"}
    password "foobar"
    password_confirmation "foobar"
  end
  factory :user1, class: User do
    username     "Cc"
    email    "cc@switter.com"
    password "203530"
    password_confirmation "203530"
    factory :admin do
      admin true
    end    
  end
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
