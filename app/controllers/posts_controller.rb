class PostsController < ApplicationController
  def index
    # find all posts of this user
    @posts = Post.where(author_id: params[:user_id])
    @user = User.where(id: params[:user_id])
  end

  def show
    # find all posts of this user
    @post = Post.where(id: params[:id])
  end
end
