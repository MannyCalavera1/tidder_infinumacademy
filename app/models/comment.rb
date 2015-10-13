class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  belongs_to :user

  scope :order_by_updated, -> { order(updated_at: :desc) }

  validates :content, :post_id, presence: true

end
