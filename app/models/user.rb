class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_token_and_nickname

  enum gender: [:male, :female]

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  has_many :subreddits, through: :subreddit_subscriptions
  has_many :subreddit_subscriptions

  def generate_token_and_nickname
    self.token = Devise.friendly_token
    self.nickname = self.email.split('@')[0]
  end

end
