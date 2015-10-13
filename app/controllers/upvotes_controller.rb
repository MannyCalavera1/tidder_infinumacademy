class UpvotesController < ApplicationController

  def create
    Upvote.create(post_id: params[:post_id])
  end


end
