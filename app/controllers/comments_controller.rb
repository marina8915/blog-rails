class CommentsController < ApplicationController
  before_action :find_post, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update]

  def new
    @comment = Comment.new(parent_id: params[:parent_id])

  rescue ActiveRecord::RecordNotFound
    redirect_to @post, alert: 'Comment not found.'
  end

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

  def edit
    redirect_access(root_path) unless check_access(@comment)
  end

  def update
    if check_access(@comment)
      if @comment.update(params.require(:comment).permit(:body))
        redirect_to comments_user_path(current_user.id), notice: 'Comment updated.'
      else
        render 'edit'
      end
    else
      redirect_access(root_path)
    end
  end


  def destroy
    @comment = @post.comments.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to comments_user_path(current_user.id), notice: 'Comment deleted.'
    else
      redirect_access(root_path)
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Post not found.'
  end

  def find_comment
    @comment = Comment.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    redirect_to @post, alert: 'Comment not found.'
  end

  def check_commenter
    @user = User.find_by_name(params[:comment][:commenter])
    @user.present? ? false : true
  end

  def save_comment
    @comment = @post.comments.create(params.require(:comment).permit(:commenter, :body, :user_id, :parent_id))
    @comment[:plus] = @comment[:minus] = 0
    @comment.save ? (redirect_to @post, notice: 'Comment created.') : (render '_form')
  end
end
