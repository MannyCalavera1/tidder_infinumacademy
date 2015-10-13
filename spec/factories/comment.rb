FactoryGirl.define do
  factory :comment do
    content 'content'
    post
    user
  end
end
