class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category Created."
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category updated."
      redirect_to category_path(@category)
    else
      render "edit"
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 4)
  end

  private

  def require_admin
    # if user is not logged in or not logged in and the current_user is not an admin...
    if !logged_in? || (logged_in? && !current_user.admin?)
      # Then flash message and redirect.
      flash[:danger] = "Only admins can perform action."
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
