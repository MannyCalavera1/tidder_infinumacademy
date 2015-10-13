class Post < ActiveRecord::Base
  belongs_to :subreddit
  belongs_to :user
  has_many :comments
  has_many :upvotes

  scope :order_by_updated, -> { order(updated_at: :desc) }

  validates :title, :content, :subreddit_id, presence: true

end
