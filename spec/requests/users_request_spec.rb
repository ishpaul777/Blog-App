require 'rails_helper'

RSpec.describe 'Users', type: :request do
  it 'all users page' do
    get '/users'
    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
    expect(response.body).to include('This is Users Page')
  end

  it 'individual user page' do
    get '/users/2'
    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
    expect(response.body).to include('This is individual user page')
  end
end
