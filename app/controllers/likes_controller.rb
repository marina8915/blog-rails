class LikesController < ApplicationController
  def create
    @comment = Comment.find(params[:like][:comment_id])
    @post = Post.find(@comment.post_id)
    if current_user
      if current_user.access
        if current_user.id != @comment.user_id
          check_user
        else
          redirect_to @post, alert: 'You can not vote for your comments.'
        end
      else
        redirect_access(@post)
      end
    else
      redirect_to @post, alert: 'Login or Sign up.'
    end
  end

  private

  def check_user
    if @comment.likes.find_by_user_id(current_user.id).nil?
      save_like
    else
      redirect_to @post, alert: 'You have already voted.'
    end
  end

  def save_like
    params[:like][:user_id] = current_user.id
    @like = @comment.likes.create(params.require(:like).permit(:like, :user_id))
    if @like.save
      case params[:like][:like]
      when '1'
        @comment.update_columns(plus: @comment.plus + 1)
      when '0'
        @comment.update_columns(minus: @comment.minus + 1)
      else
        alert = 'Wrong value'
      end
    else
      alert = 'Wrong value'
    end
    redirect_to @post, alert: alert
  end
end
