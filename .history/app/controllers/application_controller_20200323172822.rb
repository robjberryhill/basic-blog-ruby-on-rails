class ApplicationController < ActionController::Base
  # * The methods created here are available to all of your contollers, but by default not available to your views.
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
    # if user is not logged_in...
    if !logged_in?
      # Then send message to user.
      flash[:danger] = "You must be logged in to perform that action."
      # Then redirect to home page.
      redirect_to root_path
    end
  end

end
