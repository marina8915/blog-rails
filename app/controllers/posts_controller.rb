class PostsController < ApplicationController
  def index
    if params[:name]
      @posts = User.find_by_name(params[:name]).posts
    elsif params[:by]
      order_by
    else
      @posts = Post.all
    end
    @posts = @posts.search(params[:page])
  end

  def new
    if current_user.access
      @post = Post.new
    else
      redirect_to root_path
    end
  end

  def edit
    @post = find_post
    redirect_to root_path unless (current_user.access && current_user.id == @post.user_id)
  end

  def create
    if current_user.access
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @post.rating = 0
      @post.views = 0

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
    if current_user.access && current_user.id == @post.user_id
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
    if @post.publish || @post.user_id == current_user.id
      @date = @post.created_at.strftime("%F %H:%M")
      @user = User.find(@post.user_id).name
      @comments = @post.comments.search(params[:page])
      @comment = Comment.new
      @rating = Rating.new
      @video = @post.video.split('/').last
      @views = @post.update_columns(views: @post.views + 1)
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.id == find_post.user_id
      find_post.destroy
      redirect_to posts_user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  def order_by
    sort = case params[:by]
           when 'last' then 'created_at DESC'
           when 'old' then 'created_at'
           when 'high' then 'rating DESC'
           when 'low' then 'rating'
           when 'many' then 'views DESC'
           when 'less' then 'views'
           end
    @posts = Post.order(sort)
  end

  private

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :body, :img, :publish, :video, :rating, :views)
  end
end
