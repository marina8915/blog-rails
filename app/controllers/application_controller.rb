class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_access(path)
    redirect_to path, alert: 'Access is denied.'
  end

  helper_method :current_user, :redirect_access
end
