require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      Name: 'Ahmed',
      Bio: 'Full stack developer',
      Photo: 'https://www.google.com/imghp?hl=en&ogbl'
    )
  end
  describe 'GET /index' do
    before do
      get '/users'
    end

    it 'should be a successful request' do
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'Get/show' do
    before do
      get "/users/#{user.id}"
    end

    it 'should handle a successful request' do
      expect(response).to have_http_status(:ok)
    end

    it 'should respond with the right template' do
      expect(response).to render_template(:show)
    end

    it 'should response with the right data' do
      expect(response.body).to include(user.Name)
    end
  end
end
