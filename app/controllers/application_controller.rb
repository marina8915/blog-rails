class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :user_views

  private

  # dialog in user session after 10 transitions
  def user_views
    session[:views] = if current_user
                        session[:views].to_i == 10 ? 1 : session[:views].to_i + 1
                      else
                        0
                      end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_access(path)
    redirect_to path, alert: 'Access is denied.'
  end

  def check_access(item)
    if current_user
      (current_user.access && current_user.id == item.user_id) || current_user.role == 'admin'
    else
      false
    end
  end

  def find_user_like(comment)
    comment.likes.find_by_user_id(current_user.id)
  end

  helper_method :current_user, :redirect_access, :check_access, :find_user_like
end
