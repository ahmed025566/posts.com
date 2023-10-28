require 'rails_helper'

describe 'Post Model Tests' do
  user = User.create(Name: 'Tom', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'Teacher from Mexico.')
  post = Post.create(author: user, Title: 'Hello', Text: 'This is my first post')
  comment = Comment.create(user:, post:, Text: 'Hi Tom!')
  like = Like.create(user:, post:)
  it 'should be a vaild post' do
    expect(post).to be_valid
  end

  it 'should be not a vaild post if there is no a title' do
    post.Title = ''
    expect(post).to_not be_valid
    post.Title = 'Hello'
  end

  it 'comments counter and likes counter should be an integer' do
    expect(post.CommentsCounter).to be_an_integer
    expect(post.LikesCounter).to be_an_integer
    expect(post.CommentsCounter).to eq(1)
    expect(post.LikesCounter).to eql(1)
  end

  it 'should checks the assossiations' do
    expect(post.author).to be(user)
    expect(post.comments).to include(comment)
    expect(post.likes).to include(like)
  end

  it 'should list last 5 comments for a post' do
    second_comment = Comment.create(user:, post:, Text: 'comment_2')
    third_comment = Comment.create(user:, post:, Text: 'comment_3!')
    forth_comment = Comment.create(user:, post:, Text: 'comment_4')
    fifth_comment = Comment.create(user:, post:, Text: 'comment_5')
    sixth_comment = Comment.create(user:, post:, Text: 'comment_6')

    expect(post.recent_comments).to eq([sixth_comment, fifth_comment, forth_comment, third_comment, second_comment])
  end
end
