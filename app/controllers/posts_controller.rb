class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :destroy]

  def index
    if params[:name]
      user_posts
    elsif params[:by]
      @posts = Post.order(order_by)
    elsif params[:tag].present?
      @posts = Post.tagged_with(params[:tag])
    elsif params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.all
    end
    @posts = @posts.pager(params[:page]) if @posts
  end

  def new
    current_user.access ? @post = Post.new : redirect_access(root_path)
  end

  def edit
    redirect_access(root_path) unless check_access(@post)
  end

  def create
    if current_user.access
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @post.rating = @post.views = 0
      @post.save ? (redirect_to @post, notice: 'Post created.') : (render 'new')
    else
      redirect_access(root_path)
    end
  end

  def update
    if check_access(@post)
      @post.update(post_params) ? (redirect_to @post, notice: 'Post update.') : (render 'edit')
    else
      redirect_access(root_path)
    end
  end

  def show
    if @post.publish || @post.user_id == current_user.id
      @date = @post.created_at.strftime("%F %H:%M")
      @user = User.find(@post.user_id).name

      @comments = @post.comments.paginate(page: params[:page], per_page: 5)
      respond_to do |format|
        format.html
        format.js
      end
      @comment = Comment.new
      @rating = Rating.new
      @user_rating = @post.ratings.find_by_user_id(current_user.id)

      @video = @post.video.split('/').last
      @views = @post.update_columns(views: @post.views + 1)
    else
      redirect_access(root_path)
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Record not found.'
  end

  def destroy
    if current_user.id == @post.user_id
      @post.destroy
      redirect_to posts_user_path(current_user.id), notice: 'Post deleted.'
    else
      redirect_access(root_path)
    end
  end

  def order_by
    case params[:by]
    when 'date_desc' then 'created_at DESC'
    when 'date' then 'created_at'
    when 'rating_desc' then 'rating DESC'
    when 'rating' then 'rating'
    when 'views_desc' then 'views DESC'
    when 'views' then 'views'
    else redirect_to root_path
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Post not found.'
  end

  def post_params
    params.require(:post).permit(:title, :description, :body, :img, :publish,
                                 :video, :rating, :views, :tag_list)
  end

  def user_posts
    if @user = User.find_by_name(params[:name])
      @posts = @user.posts
      @posts = @posts.order(order_by) if params[:by]
    else
      redirect_to root_path
    end
  end
end
