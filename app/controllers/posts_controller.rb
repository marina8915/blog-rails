class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    if current_user
      @post = Post.new
    else
      redirect_to root_path
    end
  end

  def edit
    @post = find_post
    redirect_to root_path unless (current_user && current_user.id == @post.user_id)
  end

  def create
    if current_user
      @post = Post.new(post_params)
      @post.user_id = current_user.id

      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

  def update
    @post = find_post
    if current_user && current_user.id == @post.user_id
      if @post.update(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def show
    @post = find_post
    @date = @post.created_at.strftime("%F %H:%M")
    @user = User.find(@post.user_id).name
  end

  def destroy
    if current_user.id == find_post.user_id
      find_post.destroy

      redirect_to posts_user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  private

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :img)
  end
end
