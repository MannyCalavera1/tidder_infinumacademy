require 'rails_helper'

describe SubredditsController do
  let (:user) { FactoryGirl.create(:user) }
  let (:subreddit) { FactoryGirl.create(:subreddit) }
  let (:valid_attributes) {
    {name: 'name', description: 'description', title: 'title'}
  }
  let (:invalid_attributes) {
    {name: '', description: '', title: ''}
  }

  before { sign_in user }

  describe 'GET #new' do
    it 'renders new' do
      get :new
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #index' do
    it 'renders index' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders show' do
      get :show, id: subreddit.id
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #show trending' do
    it 'renders show in trending order' do
      get :show, id: subreddit.id, order: 'trending'
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'creates a new Subreddit' do
        expect {
          post :create, subreddit: valid_attributes
        }.to change(Subreddit, :count).by(1)
      end
    end
    context 'when invalid' do
      it 're-renders new' do
        post :create, subreddit: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end



end
