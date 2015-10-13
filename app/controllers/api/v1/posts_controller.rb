module Api
  module V1
    class PostsController < ApiController
      version 1

      def index
        expose Post.where(subreddit_id: params[:subreddit_id]).paginate(page: params[:page])
      end

      def show
        expose Post.find(params[:id]), serializer: PostSerializer
      end

      def create
        expose Post.create(post_params.merge(user_id: @user.id))
      end

      def update
        Post.find(params[:id]).update_attributes(post_params)
        expose Post.find(params[:id])
      end

      def destroy
        expose Post.find(params[:id]).destroy
      end

      def post_params
        params.permit(:title, :content, :subreddit_id)
      end

    end
  end
end
