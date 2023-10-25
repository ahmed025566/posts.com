class Like < ApplicationRecord
  after_create :update_likes_counter
  belongs_to :user
  belongs_to :post

  def update_likes_counter
    post.update(LikesCounter: +1)
  end
end
