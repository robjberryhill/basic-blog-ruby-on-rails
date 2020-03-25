class SessionsController < ApplicationController

  # new method in sessions goes to app/views/sessions/new.html.erb and displays the login form.
  def new
  end

  # For a session the create method is for logging in.
  def create
    # Find user by their email provided in the form through params
    user = User.find_by(email: params[:session][:email].downcase)
    # If the user exists and their password is correct...
    if user && user.authenticate(params[:session][:password])
      # Then assign the session user_id in the browser the actual users id
      session[:user_id] = user.id
      # Then give user the message.
      flash[:success] = "You have successfully logged in."
      # Then redirect_to the users path.
      redirect_to user_path(user)
      # If the user does not exist or is not authenticated then...
    else
      # Then give user a message about what is happening.
      flash.now[:danger] = "There was something wrong with your login information."
      # Then re render the login page.
      render "new"
    end
  end

  # For a session the destroy method is for logging out
  def destroy
    # Set the sessions browser user_id to nil/nothing.
    session[:user_id] = nil
    # Let user know what happened.
    flash[:success] = "You have logged out."
    # redirect to the home page.
    redirect_to root_path
  end

end