class Comment < ApplicationRecord
  after_create :update_comments_counter
  belongs_to :post
  belongs_to :user

  def update_comments_counter
    post.update!(CommentsCounter: post.comments.count)
  end
end
