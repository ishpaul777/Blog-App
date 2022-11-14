class PostsController < ApplicationController
  # this will show all posts of a user
  def index
    # find all posts of this user
    @posts = Post.includes(:author).where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
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

  # this will create a comment
  def create_comment
    @comment = Comment.new(comment_params)
    @comment.post = Post.find(params[:id])
    @comment.author = current_user

    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to post_path
    else
      flash.now[:error] = 'Error: Comment could not be created'
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)
    if @like.save
      flash[:success] = 'Post liked successfully'
      redirect_to post_path
    else
      flash.now[:error] = 'Error: Post could not be liked'
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
