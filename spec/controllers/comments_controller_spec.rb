require 'rails_helper'

describe CommentsController do
  let (:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  before { ActionMailer::Base.deliveries.clear }

  let (:subreddit_post) { FactoryGirl.create(:post) }
  let (:comment) { FactoryGirl.create(:comment) }
  let (:valid_attributes) {
    {content: 'content'}
  }
  let (:invalid_attributes) {
    {content: ''}
  }


  describe 'POST #create' do
    context 'when valid' do
      it 'creates a new Comment' do
        expect {
          post :create, comment: valid_attributes, post_id: subreddit_post.id
        }.to change(Comment, :count).by(1)
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end
    end
    context 'when invalid' do
      it 'doesnt create a comment' do
        expect {
          post :create, comment: invalid_attributes, post_id: subreddit_post.id
        }.to change(Comment, :count).by(0)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

end
