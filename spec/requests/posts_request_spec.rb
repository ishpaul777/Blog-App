require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    @post = Post.create(title: 'Hello', text: 'This is a post', author_id: @user.id)
  end
  it 'render all posts page' do
    get "/users/#{@user.id}/posts"
    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
  end

  it 'renders individual post page' do
    get "/users/#{@user.id}/posts/#{@post.id}"
    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
  end
end
