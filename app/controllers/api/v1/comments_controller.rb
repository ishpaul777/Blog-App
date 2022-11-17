class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_request

  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
