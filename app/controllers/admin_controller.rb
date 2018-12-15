class AdminController < ApplicationController
  def users
    if current_user.role == 'admin'
      @users = User.all.pager(params[:page])
    else
      redirect_to root_path
    end
  end
end
