class CommentsController < ApplicationController
  GUEST_ID = 100

  def create
    @post = find_post
    if !current_user && check_comment_name
      params[:comment][:user_id] = GUEST_ID
    elsif current_user
      params[:comment][:commenter] = current_user.name
      params[:comment][:user_id] = current_user.id
    end
    @comment = comment_create
    if @comment.save
      redirect_to @post
    else
      render '_form'
    end
  end

  def destroy
    @post = find_post
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to comments_user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  private

  def find_post
    Post.find(params[:post_id])
  end

  def check_comment_name
    true unless User.find_by_name(params[:comment][:commenter])
  end

  def comment_create
    @post.comments.create(params.require(:comment).permit(:commenter, :body, :user_id))
  end
end
