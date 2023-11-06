require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @user = User.create(Name: 'Ahmed', Bio: 'Teacher', Photo: 'https://thispeotexist.com/')
    @post1 = Post.create(author: @user, Title: 'post 1', Text: 'first post')
    @post2 = Post.create(author: @user, Title: 'post 2', Text: 'second post')
    @post3 = Post.create(author: @user, Title: 'post 3', Text: 'third post')
    @post4 = Post.create(author: @user, Title: 'post 4', Text: 'forth post')
  end

  it 'should display the user profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://thispeotexist.com/']")
  end

  it 'should display the user name' do
    visit user_path(@user)
    expect(page).to have_content(@user.Name)
  end

  it 'should display number of posts for the user' do
    visit user_path(@user)
    expect(page).to have_content("Number of posts: #{@user.PostsCounter}")
  end

  it 'should display the bio of the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.Bio)
  end

  it 'should display the first three posts of the user' do
    visit user_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
    expect(page).to have_content(@post4.Title)
    expect(page).to have_content(@post3.Title)
    expect(page).to have_content(@post2.Title)
  end

  it 'should display the button that leads to posts index' do
    visit user_path(@user)
    expect(page).to have_selector(:link_or_button, 'See all posts')
  end

  it 'should redirects me to the post show page' do
    visit user_path(@user)
    click_link @post4.Title
    expect(current_path).to eq(user_post_path(user_id: @user.id, id: @post4.id))
  end

  it 'should redirects me to the post index page' do
    visit user_path(@user)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(user_id: @user.id))
  end
end
