class CommentsController < ApplicationController
  def create
    @post = post
    if !current_user && check_comment_name
      @comment = comment_create
    elsif current_user
      params[:comment][:commenter] = current_user.name
      @comment = comment_create
    end
      redirect_to @post
  end

  def destroy
    @post = post
    @comment = @post.comments.find(params[:id])
    if current_user.name == @comment.commenter
      @comment.destroy
      redirect_to my_comments_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  private

  def post
    Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def check_comment_name
    true unless User.find_by_name(params[:comment][:commenter])
  end

  def comment_create
    @post.comments.create(comment_params)
  end
end
