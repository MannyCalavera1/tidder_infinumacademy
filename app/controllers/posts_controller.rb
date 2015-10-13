class PostsController < ApplicationController

  def show
    @enable_new_post = true
    @post = Post.find(params[:id])
    @subreddit = Subreddit.find(@post.subreddit_id)
    @comment = Comment.new
  end

  def new
    @subreddit = Subreddit.find(params[:subreddit_id])
    @post = @subreddit.posts.new
  end

  def create
    @subreddit = Subreddit.find(params[:subreddit_id])
    @post = @subreddit.posts.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to subreddit_path(@subreddit.id)
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to subreddits_path
  end


end
