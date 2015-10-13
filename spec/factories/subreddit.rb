FactoryGirl.define do
  factory :subreddit do
    sequence(:name) { |n| "Subreddit name #{n}" }
    description 'description'
    title 'title'
  end
end
