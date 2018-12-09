class LikesController < ApplicationController
  def create
    @comment = find_comment
    @post = Post.find(@comment.post_id)
    if current_user && check_user
      params[:like][:user_id] = current_user.id
      @like = @comment.likes.create(params.require(:like).permit(:like, :user_id))
      if @like.save
        if params[:like][:like] == '1'
          @comment.update_columns(plus: @comment.plus + 1)
        else
          @comment.update_columns(minus: @comment.minus + 1)
        end
        redirect_to @post
      end
    else
      redirect_to @post
    end
  end

  private

  def check_user
    @comment = find_comment
    @like = @comment.likes.find_by_user_id(current_user.id)
    @like.nil?
  end

  def find_comment
    Comment.find(params[:like][:comment_id])
  end
end
