class SubredditSubscriptionsController < ApplicationController

  def create
    current_user.subreddit_subscriptions.create(subreddit_id: params[:subreddit_id])
  end

  def destroy
    SubredditSubscription.find_by(user_id: current_user.id, subreddit_id: params[:subreddit_id]).destroy
  end

end
