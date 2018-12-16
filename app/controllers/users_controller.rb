class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def posts
    if current_user
      @posts = current_user.posts.pager(params[:page])
    else
      redirect_access(root_path)
    end
  end

  def comments
    if current_user
      @comments = current_user.comments.pager(params[:page])
    else
      redirect_access(root_path)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.access = true
    @user.role = 'user'
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{current_user.name}"
    else
      render 'new'
    end
  end

  def update
    if current_user.role == 'admin'
      data = admin_params
    else
      data = user_params
    end
    if @user.update_attributes(data)
      redirect_to current_user.role == 'admin' ? admin_users_path : user_path(current_user.id)
    else
      render 'edit'
    end
  end

  private

  def find_user
    if current_user
      find_id = current_user.role == 'admin' ? params[:id] : current_user.id
      @user = User.find(find_id)
    else
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def admin_params
    params.require(:user).permit(:name, :email, :password, :access)
  end
end
