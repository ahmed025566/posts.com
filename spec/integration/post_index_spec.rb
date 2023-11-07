require 'rails_helper'

RSpec.describe 'Post index ', type: :feature do
  before do
    @user = User.create(Name: 'Ahmed', Bio: 'Teacher', Photo: 'https://thispeotexist.com/')
    @post1 = Post.create(author: @user, Title: 'post 1', Text: 'first post')
    @post2 = Post.create(author: @user, Title: 'post 2', Text: 'second post')
    @post3 = Post.create(author: @user, Title: 'post 3', Text: 'third post')
    @post4 = Post.create(author: @user, Title: 'post 4', Text: 'forth post')
    @post5 = Post.create(author: @user, Title: 'post 5', Text: 'fifth post')
    @comment1 = Comment.create(user: @user, post: @post1, Text: 'first comment')
    @comment2 = Comment.create(user: @user, post: @post1, Text: 'second comment')
    @comment3 = Comment.create(user: @user, post: @post1, Text: 'third comment')
    @comment4 = Comment.create(user: @user, post: @post1, Text: 'forth comment')
    @comment5 = Comment.create(user: @user, post: @post1, Text: 'fifth comment')
    @like1 = Like.create(user: @user, post: @post1)
  end

  it 'should display the user profile picture' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='https://thispeotexist.com/']")
  end

  it 'should display the user name' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.Name)
  end

  it 'should display number of posts for the user' do
    visit user_posts_path(@user)
    expect(page).to have_content("Number of posts: #{@user.PostsCounter}")
  end

  it 'should display posts titles' do
    visit user_posts_path(@user)

    expect(page).to have_content(@post3.Title)
    expect(page).to have_content(@post2.Title)
    expect(page).to have_content(@post1.Title)
  end

  it 'should display posts bodies' do
    visit user_posts_path(@user)

    expect(page).to have_content(@post3.Text)
    expect(page).to have_content(@post2.Text)
    expect(page).to have_content(@post1.Text)
  end

  it 'should display the 5first comments on a post' do
    visit user_posts_path(@user)
    expect(@post1.CommentsCounter).to eq(5)
    expect(@post1.comments).to include(@comment1)
    expect(page).to have_content(@comment1.Text)
    expect(page).to have_content(@comment2.Text)
    expect(page).to have_content(@comment3.Text)
  end

  it 'should display how many comments a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content("Comments: #{@post1.CommentsCounter}")
  end

  it 'should display how many likes a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content("Likes: #{@post1.LikesCounter}")
  end

  it 'should redirects me to the post show page' do
    visit user_posts_path(@user)
    click_link @post2.Text
    expect(current_path).to eq(user_post_path(user_id: @user.id, id: @post2.id))
  end

  it 'should render pagination if number of posts is more than 5' do
    visit user_posts_path(@user)
    expect(page).to_not have_content('← Previous 1 2 Next →')
  end
end
