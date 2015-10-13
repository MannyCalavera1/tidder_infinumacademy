FactoryGirl.define do
  factory :user do
    nickname 'nickname'
    sequence(:email) { |n| "user#{n}@tidder.com" }
    password 'password'
  end
end
