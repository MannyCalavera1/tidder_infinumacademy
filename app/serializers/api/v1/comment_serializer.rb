module Api
  module V1
    class CommentSerializer < ActiveModel::Serializer
      attributes :id, :content

      has_one :user
    end
  end
end
