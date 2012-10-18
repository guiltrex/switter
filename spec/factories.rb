FactoryGirl.define do
  factory :user do
    username     "rex"
    email    "guiltzero@gmail.com"
    password "203530"
    password_confirmation "203530"
  end
  factory :user2, class: User do
    username     "cc"
    email    "cc@switter.com"
    password "203530"
    password_confirmation "203530"
  end
end
