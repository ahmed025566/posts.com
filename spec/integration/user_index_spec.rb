require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    # Create some sample users in the database
    @user1 = User.create(Name: 'Ahmed', Bio: 'Teacher', Photo: 'https://thispeotexist.com/')
    @user2 = User.create(Name: 'Tom', Bio: 'Doctor', Photo: 'https://thispersondoestexist.com/')
  end

  it 'displays the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.Name)
    expect(page).to have_content(@user2.Name)
  end

  it 'displays the profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='https://thispeotexist.com/']")
    expect(page).to have_css("img[src*='https://thispersondoestexist.com/']")
  end

  it 'displays the number of posts each user has written' do
    # Create some posts for the users
    @user1.posts.create(Title: 'Post 1', Text: 'Text 1')
    @user2.posts.create(Title: 'Post 2', Text: 'Text 2')
    visit users_path
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 1')
  end

  it "redirects to the user's show page when clicked" do
    visit users_path
    click_link @user1.Name
    expect(current_path).to eq(user_path(@user1))
  end
end
