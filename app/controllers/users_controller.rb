class UsersController < ApplicationController
  def posts
    if current_user
      @posts = User.find(current_user.id).posts.search(params[:page])
    else
      redirect_to root_path
    end
  end

  def comments
    if current_user
      @comments = User.find(current_user.id).comments.search(params[:page])
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def edit
    find_user
  end

  def show
    find_user
  end

  def create
    @user = User.new(user_params)
    @user.access = true
    @user.role = 'user'
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    find_user
    if @user.update_attributes(user_params)
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
    params.require(:user).permit(:name, :email, :password, :access, :role)
  end
end
