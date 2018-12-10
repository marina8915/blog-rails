class LikesController < ApplicationController
  def create
    @comment = find_comment
    @post = Post.find(@comment.post_id)
    if current_user
      if current_user.access
        if current_user.id != @comment.user_id
          check_user ? save_like : (redirect_to @post, alert: 'You have already voted.')
        else
          redirect_to @post, alert: 'You can not vote for your comments.'
        end
      else
        redirect_to @post, alert: 'Access is denied.'
      end
    else
      redirect_to @post, alert: 'Login or Sign up.'
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

  def save_like
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
  end
end
