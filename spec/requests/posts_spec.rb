require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) do
    User.create(
      Name: 'Ahmed',
      Bio: 'Full stack developer',
      Photo: 'https://www.google.com/imghp?hl=en&ogbl'
    )
  end

  let(:post) do
    Post.create(
      Title: 'First post',
      Text: 'This is my first post',
      author: user
    )
  end
  describe 'GET /index' do
    before do
      get "/users/#{user.id}/posts"
    end

    it 'should be a successful request' do
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end
end
