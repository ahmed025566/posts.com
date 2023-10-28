require 'rails_helper'

describe 'Comment Model Tests' do
  user = User.create(Name: 'Tom', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'Teacher from Mexico.')
  post = Post.create(author: user, Title: 'Hello', Text: 'This is my first post')

  it 'should increment the comments counter by 1 for a post' do
    expect(post.CommentsCounter).to_not be_nil
    comment = Comment.create(user: user, post:, Text: 'Hi Tom!')
    expect(post.CommentsCounter).to eql(1)
    expect(comment.user).to eql(user)
    expect(post.comments).to include(comment)
  end
end