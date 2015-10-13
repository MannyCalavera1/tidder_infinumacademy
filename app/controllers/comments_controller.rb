class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      Notifications.comments(@post.user, @post, @comment).deliver_now
    end

    redirect_to post_path(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end


end
