require 'rails_helper'

describe Post do

  let(:post) { FactoryGirl.create(:post) }

  it { should have_many(:comments) }
  it { should have_many(:upvotes) }
  it { should belong_to(:user) }
  it { should belong_to(:subreddit) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:subreddit_id) }

  describe '.order_by_updated' do
    let (:alpha) { FactoryGirl.create(:post, title: 'alpha') }
    let (:beta) { FactoryGirl.create(:post, title: 'beta', updated_at: Time.now + 3.seconds) }
    let (:gamma) { FactoryGirl.create(:post, title: 'gamma', updated_at: Time.now + 6.seconds) }

    it 'orders by updated_at' do
      expect(Post.order_by_updated).to eq([gamma, beta, alpha])
    end
  end

end
