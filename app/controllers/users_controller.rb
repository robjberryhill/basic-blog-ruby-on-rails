class UsersController < ApplicationController

  # This method runs specified methods before any of the other actions. You can specify only: certain :actions to apply the specified method to.
  before_action :set_user, only: [:edit, :update, :show]

  # Before any other action call the require_user method from the application_controller.
  # This will require the a user to be logged in for only edit and update.
  before_action :require_user, only: [:edit, :update, :destroy]

  # Before any other action require the same user for only edit and update.
  # We only want the user that created this record to be able to edit or update or destroy it.
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # Before any other action require the admin user for only destroy.
  # We only want an admin to be able to delete any user.
  before_action :require_admin, only: [:destroy]

  def index
    # Set @users instance variable to all users.
    # @users = User.all

    # Set @users instance variable to paginate this view to 4 users per_page.
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def new
    # Set @user instance variable to a new user to be used in the form.
    @user = User.new
  end

  # Just grants the ability for the edit page.
  def edit
  end

  def update

    # If there is a user with params to update...
    if @user.update(user_params)

      # Then send user message...
      flash[:success] = "Account Updated"
      # Then send to all articles.
      redirect_to articles_path

      # If not re render the edit page.
    else
      render :edit
    end

  end

  def show
    # Assigns all article records to the @user_articles instance variable.
    # Adds pagination to all user articles using the gem 'will_paginate', '3.1.5' gem 'bootstrap-will_paginate', '1.0.0'
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def destroy
    # Set the user to a specific user found by the id.
    @user = User.find(params[:id])
    # Then delete that user...
    @user.destroy
    # Then send the user a message...
    flash[:danger] = "User and all articles created by user have been deleted."
    # Then redirect_to the path to the list of users.
    redirect_to users_path
  end

  def create
    # Set @user to a new user with the params passed in...
    @user = User.new(user_params)
    # Then save the user record....
    if @user.save
      # Then sign in the user when they create the account.
      session[:user_id] = @user.id
      # Then send the user a message...
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      # redirect_to articles_path
      # Then redirect to the users account page.
      redirect_to user_path(@user)
    # If user is not saved then re render the new user page.
    else
      render :new
    end
  end

  private

  def user_params
    # returns params that require a user and permit the parameters username, email and password.
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    # Set the user to a specific user found by the id.
    @user = User.find(params[:id])
  end

  def require_same_user

    # if there is a current user(this method is from application_controller) and it is not the user for the record and if current_user is not an admin...
    if current_user != @user and !current_user.admin?
        # Then flash danger message to the user.
        flash[:danger] = "This is not your account."
        # Then redirect to the home page.
        redirect_to root_path
    end
  end

  def require_admin
    # If there is a user logged_in? and they are not an admin...
    if logged_in? and !current_user.admin?
      # Then send user a message...
      flash[:danger] = "You are not authorized to perform that action."
      # Then redirect_to to home page.
      redirect_to root_path
    end
  end

end
