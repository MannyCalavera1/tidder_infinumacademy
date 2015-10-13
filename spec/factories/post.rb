FactoryGirl.define do
  factory :post do
    title 'nickname'
    content 'content'
    user
    subreddit
  end
end
