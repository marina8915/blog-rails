class CommentsController < ApplicationController
  GUEST_ID = 100
  def create
    @post = find_post
    if !current_user && check_comment_name
      params[:comment][:user_id] = GUEST_ID
      @comment = comment_create
    elsif current_user
      params[:comment][:commenter] = current_user.name
      params[:comment][:user_id] = current_user.id
      @comment = comment_create
    end
    redirect_to @post
  end

  def destroy
    @post = find_post
    @comment = @post.comments.find(params[:id])
    if current_user.name == @comment.commenter
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
