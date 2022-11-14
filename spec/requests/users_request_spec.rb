require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    @post = Post.create(title: 'Hello', text: 'This is a post', author_id: @user.id)
  end

  it 'all users page' do
    get '/users'
    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
  end

  it 'individual user page' do
    get "/users/#{@user.id}"
    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
  end
end
