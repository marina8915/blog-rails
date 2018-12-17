class LikesController < ApplicationController
  before_action :find_comment, only: [:create, :show, :destroy]
  before_action :find_post, only: [:create, :destroy]

  def create
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

  def destroy
    @like = Like.find(params[:id])
    if current_user.id == @like.user_id
      change_like(@like.like, 'minus')
      @like.destroy
      redirect_to @post, notice: 'Mark deleted.'
    else
      redirect_access(@post)
    end
  end

  private

  def find_post
    @post = Post.find(@comment.post_id)

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Post not found.'
  end

  def find_comment
    if params[:like]
      @comment = Comment.find(params[:like][:comment_id])
    else
      @comment = Comment.find(params[:comment_id])
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to @post, alert: 'Comment not found.'
  end

  def check_user
    @like = @comment.likes.find_by_user_id(current_user.id)
    if @like.nil?
      save_like
    else
      like = @like.like ? '1' : '0'
      if like == params[:like][:like]
        redirect_to @post, notice: 'Mark not changed.'
      else
        change_like(@like.like, 'minus')
        change_like(params[:like][:like], 'plus')
        @like.update_columns(like: params[:like][:like])
        redirect_to @post, notice: 'Your mark changed.'
      end
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to @post, alert: 'Like not found.'
  end

  def save_like
    params[:like][:user_id] = current_user.id
    @like = @comment.likes.create(params.require(:like).permit(:like, :user_id))
    save_result
  end

  def save_result
    if @like.save
      if params[:like][:like] == '1'
        @comment.update_columns(plus: @comment.plus + 1)
      else
        @comment.update_columns(minus: @comment.minus + 1)
      end
      redirect_to @post, notice: 'Your mark saved.'
    else
      redirect_to @post, alert: 'Wrong value'
    end
  end

  def change_like(like, action)
    if action == 'plus'
      if like == '1'
        @comment.update_columns(plus: @comment.plus + 1)
      else
        @comment.update_columns(minus: @comment.minus + 1)
      end
    elsif action == 'minus'
      if like
        @comment.update_columns(plus: @comment.plus - 1)
      else
        @comment.update_columns(minus: @comment.minus - 1)
      end
    end
  end
end
