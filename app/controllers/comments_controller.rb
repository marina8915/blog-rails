class CommentsController < ApplicationController
  def create
    @post = post
    @comment = @post.comments.create(comment_params)
    redirect_to @post
  end

  def destroy
    @post = post
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to my_comments_path(current_user.id)
  end

  private

  def post
    Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
