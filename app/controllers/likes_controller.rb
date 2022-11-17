class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)
    if @like.save
      flash[:success] = 'Post liked successfully'
      redirect_to post_path
    else
      flash.now[:error] = 'Error: Post could not be liked'
    end
  end
end
