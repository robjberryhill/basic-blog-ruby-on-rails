class UsersController < ApplicationController

  # This method runs specified methods before any of the other actions. You can specify only: certain :actions to apply the specified method to.
  before_action :set_user, only: [:edit, :update, :show]

  # Before any other action require the same user for only edit and update.
  # We only want the user that created this record to be able to edit or update or destroy it.
  before_action :require_same_user, only: [:edit, :update]

  def index
    # Set @users instance variable to all users.
    # @users = User.all

    # Set @users instance variable to paginate this view to 4 users per_page.
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Account Updated"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end