module Api
  module V1
    class ApiController < RocketPants::Base
      before_action :authenticate!

      private

      def authenticate!
        @user = User.find_by(token: params[:token])
        if @user.nil? then error! :unauthenticated end
      end

    end
  end
end
