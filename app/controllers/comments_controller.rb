class CommentsController < ApplicationController
  GUEST_ID = 100

  def create
    @post = find_post
    if !current_user && check_comment_name
      params[:comment][:user_id] = GUEST_ID
      save_comment
    elsif current_user.access
      params[:comment][:commenter] = current_user.name
      params[:comment][:user_id] = current_user.id
      save_comment
    else
      redirect_to @post, alert: 'Access is denied.'
    end
  end

  def destroy
    @post = find_post
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to comments_user_path(current_user.id)
    else
      redirect_to root_path, alert: 'Access is denied.'
    end
  end

  private

  def find_post
    Post.find(params[:post_id])
  end

  def check_comment_name
    true unless User.find_by_name(params[:comment][:commenter])
  end

  def save_comment
    @comment = @post.comments.create(params.require(:comment).permit(:commenter, :body, :user_id))
    @comment[:plus] = @comment[:minus] = 0
    if @comment.save
      redirect_to @post
    else
      render '_form'
    end
  end
end
