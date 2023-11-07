require 'rails_helper'

RSpec.describe 'Post show page ', type: :feature do
  before do
    @user = User.create(Name: 'Ahmed', Bio: 'Teacher', Photo: 'https://thispeotexist.com/')
    @post = Post.create(author: @user, Title: 'post 1', Text: 'first post')
    @comment = Comment.create(user: @user, post: @post, Text: 'first comment')
  end

  it 'should display post tilte' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.Title)
  end

  it 'should display the author name' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@user.Name)
  end

  it 'should display the comments counter' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content("Comments: #{@post.CommentsCounter}")
    expect(page).to have_content("Likes: #{@post.LikesCounter}")
  end

  it 'should display the post body' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.Text)
  end
end
