class SubredditsController < ApplicationController

  def index
    @subreddits_list = Subreddit.all
  end

  def show
    @enable_new_post = true
    @subreddit = Subreddit.find(params[:id])

    if params[:order] == 'trending'
      @posts = @subreddit.posts.includes(:user).sort_by {|e| -e.upvotes_count / ((Time.now - e.created_at) / 1.hour)**1.8 }
    else
      @posts = @subreddit.posts.order_by_updated.includes(:user)
    end

  end

  def new
    @subreddit = Subreddit.new
  end

  def create
    @subreddit = Subreddit.new(subreddit_params)

    if @subreddit.save
      redirect_to root_path
    else
      render :new
    end
  end

  def subreddit_params
    params.require(:subreddit).permit(:name, :description, :title)
  end

end
