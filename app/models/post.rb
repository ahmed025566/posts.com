class Post < ApplicationRecord
  after_create :update_posts_counter

  validates :Title, presence: true
  validates :Title, length: { maximum: 250 }
  validates :CommentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nill: true }
  validates :LikesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nill: true }
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_posts_counter
    author.update!(PostsCounter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
