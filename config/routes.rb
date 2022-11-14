Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'users#index'
  get "/users", to: "users#index" #  requires a view
  get '/users/:user_id', to: 'users#show' #  requires a view
  get '/users/:user_id/posts', to: 'posts#index'
  get 'posts/new', to: 'posts#new', as: 'new_post' # new
  post '/posts/new', to: 'posts#create', as: 'create_post' # create
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'post' # show
  post '/users/:user_id/posts/:id', to: 'posts#create_comment'
  post '/users/:user_id/posts/:id/like', to: 'posts#like', as: 'like_post'
end
