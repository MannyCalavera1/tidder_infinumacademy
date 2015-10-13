module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :nickname, :gender, :subreddit_ids
    end
  end
end
