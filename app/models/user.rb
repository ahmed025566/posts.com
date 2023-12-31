class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :Name, presence: true
  validates :PostsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nill: true }
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
