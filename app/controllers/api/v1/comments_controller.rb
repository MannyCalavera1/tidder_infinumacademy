module Api
  module V1
    class CommentsController < ApiController
      version 1

      def index
        expose Post.find(params[:post_id]).comments, each_serializer: CommentSerializer
      end

      def create
        expose Comment.create(comment_params.merge(user_id: @user.id))
      end

      def destroy
        expose Comment.find(params[:id]).destroy
      end

      def comment_params
        params.permit(:content, :post_id)
      end

    end
  end
end
