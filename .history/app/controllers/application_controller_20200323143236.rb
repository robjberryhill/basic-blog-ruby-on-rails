class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    # If there was already a current user found then return that or if not then find and return the current user.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # Turn into a boolean with !! to return true or false.
    !!current_user
  end

  def require_user
    
  end

end
