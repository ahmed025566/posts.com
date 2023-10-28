require 'rails_helper'

describe 'Likes Model Tests' do
  user = User.create(Name: 'Tom', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'Teacher from Mexico.')
  post = Post.create(author: user, Title: 'Hello', Text: 'This is my first post')

  it 'should incrment likes counter by 1' do
    expect(post.LikesCounter).to_not be_nil
    like = Like.create(user:, post:)
    expect(post.LikesCounter).to eq(1)
    expect(like.user).to eq(user)
    expect(post.likes).to include(like)
  end
end
