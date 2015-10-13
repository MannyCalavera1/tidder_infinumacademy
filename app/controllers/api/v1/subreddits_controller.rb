module Api
  module V1
    class SubredditsController < ApiController
      version 1

      def index
        expose Subreddit.paginate(page: params[:page])
      end

      def show
        expose Subreddit.find(params[:id]), serializer: SubredditSerializer
      end

      def create
        expose Subreddit.create(subreddit_params.merge(user_id: @user.id))
      end

      def update
        Subreddit.find(params[:id]).update_attributes(subreddit_params)
        expose Subreddit.find(params[:id])
      end

      def destroy
        expose Subreddit.find(params[:id]).destroy
      end

      def subreddit_params
        params.permit(:name, :description, :title)
      end

    end
  end
end
