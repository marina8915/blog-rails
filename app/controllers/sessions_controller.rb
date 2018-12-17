class SessionsController < ApplicationController
  def create
    @user = User.find_by_name(params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
