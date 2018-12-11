class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def create
    if !current_user && check_commenter
      save_comment
    elsif current_user.access
      params[:comment][:commenter] = current_user.name
      params[:comment][:user_id] = current_user.id
      save_comment
    else
      redirect_access(@post)
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to comments_user_path(current_user.id)
    else
      redirect_access(root_path)
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def check_commenter
    @user = User.find_by_name(params[:comment][:commenter])
    @user.present? ? false : true
  end

  def save_comment
    @comment = @post.comments.create(params.require(:comment).permit(:commenter, :body, :user_id))
    @comment[:plus] = @comment[:minus] = 0
    @comment.save ? (redirect_to @post) : (render '_form')
  end
end
