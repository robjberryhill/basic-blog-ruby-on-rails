class ArticlesController < ApplicationController
    # This calls this method :set_article before the action is called. and only in the specified actions. To prevent redundance and set the article in each method that needs it.
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    before_action :require_user, except: [:index, :show]
    
    # The index of a particular table is usually the page to list out all of the records.
    def index
        # Assigns all article records to the @articles instance variables.
        # @articles = Article.paginate(page: params[:page])
        # Adds pagination to all articles using the gem 'will_paginate', '3.1.5' gem 'bootstrap-will_paginate', '1.0.0'
        @articles = Article.paginate(page: params[:page], per_page: 4)
    end

    # @ specifies an instance varible.
    # @ here it is being set to a new Article object.
    def new
        @article = Article.new()
    end

    # Looking at rake routes you will find the edit page is displayed /articles/:id/edit
    # We need to set the @article instance to a specific id to be able to edit a particular record.
    def edit
    end
    
    def create

        # render plain: params[:article].inspect
        # @article.save
        # redirect_to articles_path(@article)

        # Creates a new Article object
        @article = Article.new(article_params)

        @article.user = User.first

        # Handles if Articles saves or not based on the validations on the model.
        if @article.save
            # If article saves then redirect to the article with a message.
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            # If article does not save the re render the new article page. Errors displayed and handled on the new.html.erb
            render :new
        end
    end

    # This is the page that handles the submission of the edit/update method/page.
    def update
        # If the record successfully updates the notify and send back to the article page with the updated info.
        # We need to update something so we again need to white list the information with the article_params method like we did when creating.
        if @article.update(article_params)
            flash[:success] = "Article was successfully updated."
            redirect_to article_path(@article)

            # Else go back to the edit page.
        else
            render :edit
        end
    end

    #this handles the submission of a new article.
    def show
    end

    # This handles the delete ability of the app.
    def destroy
        # Deletes the record.
        @article.destroy
        flash[:danger] = "Article was successfully deleted."

        # Sends you back to the main list of articles.
        redirect_to articles_path
    end

    private

    def set_article
        # Set the @article variable instance to the specific record based on the id.
        @article = Article.find(params[:id])
    end

    def article_params
        # params.requires(:toplevelkey).permit(:secondlevelone, :secondleveltwo)
        # This info is like recieving a json or xml object and being able to change the info.
        params.require(:article).permit(:title, :description)
    end

end