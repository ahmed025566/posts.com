require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(Name: 'Tome', Bio: 'teacher', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo')

  it 'should be valid if it has a name' do
    expect(user).to be_valid
  end

  it 'should not be valid if the name is blank' do
    user.Name = ''
    expect(user).to_not be_valid
    user.Name = 'Tom'
    expect(user).to be_valid
  end

  it 'should not be vaild if posts counter recievied none integer value' do
    user.PostsCounter = 'string'
    expect(user).to_not be_valid
    user.PostsCounter = 0
    expect(user).to be_valid
  end

  it 'should not be vaild if the posts couner recvied negative value' do
    user.PostsCounter = -2
    expect(user).to_not be_valid
  end

  it 'should return the most recent 3 posts for a user' do
    Post.create(author: user, Title: 'Hello', Text: 'first post')
    second_post = Post.create(author: user, Title: 'Hello', Text: 'second post')
    third_post = Post.create(author: user, Title: 'Hello', Text: 'third post')
    forth_post = Post.create(author: user, Title: 'Hello', Text: 'forth post')
    expect(user.recent_posts).to eq([forth_post, third_post, second_post])
  end
end
