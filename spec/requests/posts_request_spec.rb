require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  it 'render all posts page' do
    get '/users/2/posts'
    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
    expect(response.body).to include('This is users Posts Page')
  end

  it 'renders individual post page' do
    get '/users/2/posts/1'
    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
    expect(response.body).to include('This is individual post page')
  end
end
