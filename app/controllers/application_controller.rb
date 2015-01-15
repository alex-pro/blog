class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :authenticate, except: [:index, :show]

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def check_current_user
    redirect_to root_path if logged_in?
  end

  def authenticate
    redirect_to log_in_path unless logged_in?
  end

end
