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

  # this will create a comment
  def create_comment
    @comment = Comment.new(comment_params)
    @comment.post = Post.find(params[:id])
    @comment.author = current_user

    if @comment.save
      flash[:notice] = 'Comment created successfully'
      redirect_to post_path
    else
      flash.now[:alert] = 'Error: Comment could not be created'
    end
  end

  # this will delete a comment
  def destroy_comment
    @comment = Comment.find(params[:comment])
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Comment was successfully deleted.'
        redirect_to "/users/#{@comment.post.id}/posts/#{@comment.post.id}"
      end
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)
    if @like.save
      flash[:notice] = 'Post liked successfully'
      redirect_to post_path
    else
      flash.now[:alert] = 'Error: Post could not be liked'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def comment_params
    params.require(:form_comment).permit(:text)
  end
end
