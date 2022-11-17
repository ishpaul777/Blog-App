Rails.application.routes.draw do
  devise_for :users
  
  # delete '/users/sign_out', to: 'devise/sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # where should be the deleet route for comments?
  root to: 'users#index'
  get "/users", to: "users#index", as: 'user' #  requires a view
  get '/users/:user_id', to: 'users#show' #  requires a view
  get '/users/:user_id/posts', to: 'posts#index'
  get 'posts/new', to: 'posts#new', as: 'new_post' # new
  post '/posts/new', to: 'posts#create', as: 'create_post' # create
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'post' # show
  delete '/users/:user_id/posts/:id', to: 'posts#destroy', as: 'delete_post' # delete
  post '/users/:user_id/posts/:id', to: 'comments#create', as: 'post_comments' # create
  delete '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy', as: 'delete_comment' # delete
  post '/users/:user_id/posts/:id/like', to: 'likes#create', as: 'like_post' # create
  
end
