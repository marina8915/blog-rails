class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = find_post
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = find_post
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
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

      redirect_to my_posts_path(current_user.id)
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
