class UsersController < ApplicationController
  def my_posts
    @posts = find_user.posts
  end

  def my_comments
    @comments = Comment.all.select { |comment| comment.commenter == current_user.name }
  end

  def new
    @user = User.new
  end

  def edit
    @user = find_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = find_user

    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
