class PostsController < ApplicationController
  load_and_authorize_resource

  # this will show all posts of a user
  def index
    # find all posts of this user
    if user_signed_in?
      @posts = Post.includes(:author).where(author_id: params[:user_id])
      @user = User.find(params[:user_id])
    else
      redirect_to new_user_session_path
    end
  end

  # this will show a post
  def show
    # find all posts of this user
    @post = Post.includes(:author).find(params[:id])
    @user = @post.author
  end

  def new
    @post = Post.new
  end

  # this will create a post
  def create
    @user = current_user
    @post = Post.create(post_params)
    @post.author_id = @user.id
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post was successfully created.'
          redirect_to "/users/#{@user.id}/posts/#{@post.id}"
        else
          flash[:error] = 'Post was not created.'
          render :new
        end
      end
    end
  end

  # this will delete a post
  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    # delete all comments of this post
    @post.comments.each(&:destroy)
    # delete all likes of this post
    @post.likes.each(&:destroy)
    @post.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Post was successfully deleted.'
        redirect_to "/users/#{@user.id}"
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
