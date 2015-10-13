class Subreddit < ActiveRecord::Base
  has_many :posts

  scope :order_by_updated, -> { order(updated_at: :desc) }

  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :description, length: { maximum: 500 }

end
