class StaticPagesController < ApplicationController

  def index
    @posts = Post.where(subreddit_id: current_user.subreddits.map(&:id)).paginate(:page => params[:page], :per_page => 10)
  end

end
