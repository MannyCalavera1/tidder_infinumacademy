require 'rails_helper'

describe Subreddit do

  let(:subreddit) { FactoryGirl.create(:subreddit) }

  it { should have_many(:posts) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_least(3) }
  it { should validate_length_of(:name).is_at_most(20) }

  describe '.order_by_updated' do
    let (:alpha) { FactoryGirl.create(:subreddit, name: 'alpha', title: 'alpha') }
    let (:beta) { FactoryGirl.create(:subreddit, name: 'beta', title: 'beta', updated_at: Time.now + 3.seconds) }
    let (:gamma) { FactoryGirl.create(:subreddit, name: 'gamma', title: 'gamma', updated_at: Time.now + 6.seconds) }

    it 'orders by updated_at' do
      expect(Subreddit.order_by_updated).to eq([gamma, beta, alpha])
    end
  end

end
