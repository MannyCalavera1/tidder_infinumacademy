require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  it { should validate_length_of(:password).is_at_least(8)}

  it { should have_many(:subreddits) }
  it { should have_many(:subreddit_subscriptions) }

  it 'token should not be nil' do
    expect(user.token).to be_truthy
  end

end
