class CommentsController < ApplicationController
  load_and_authorize_resource

  # this will create a comment
  def create
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

  def destroy
    @comment = Comment.find(params[:comment])
    @comment.destroy
    flash[:notice] = 'Comment deleted successfully'
    redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}"
  end

  private

  def comment_params
    params.require(:form_comment).permit(:text)
  end
end
