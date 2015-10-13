require 'rails_helper'

describe Comment do

  let(:comment) { FactoryGirl.create(:comment) }

  it { should belong_to(:post) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:post_id) }
  it { should validate_presence_of(:content) }

  describe '.order_by_updated' do
    let (:alpha) { FactoryGirl.create(:comment) }
    let (:beta) { FactoryGirl.create(:comment, updated_at: Time.now + 3.seconds) }
    let (:gamma) { FactoryGirl.create(:comment, updated_at: Time.now + 6.seconds) }

    it 'orders by updated_at' do
      expect(Comment.order_by_updated).to eq([gamma, beta, alpha])
    end
  end

end
