require 'rails_helper'

describe PostsController do
  let (:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  let (:subreddit) { FactoryGirl.create(:subreddit) }
  let (:subreddit_post) { FactoryGirl.create(:post) }

  let (:valid_attributes) {
    {title: 'title', content: 'content'}
  }
  let (:invalid_attributes) {
    {title: '', content: ''}
  }



  describe 'GET #new' do
    it 'renders new' do
      get :new, subreddit_id: subreddit.id
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'renders show' do
      get :show, id: subreddit_post.id
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'creates a new Post' do
        expect {
          post :create, post: valid_attributes, subreddit_id: subreddit.id
        }.to change(Post, :count).by(1)
      end
    end
    context 'when invalid' do
      it 're-renders new' do
        post :create, post: invalid_attributes, subreddit_id: subreddit.id
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a Post' do
      subreddit_post
      expect {
        subreddit_post
        delete :destroy, id: subreddit_post.id
      }.to change(Post, :count).by(-1)
    end
  end

end
