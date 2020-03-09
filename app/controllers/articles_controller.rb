class ArticlesController < ApplicationController

    # @ specifies an instance varible.
    # @ here it is being set to a new Article object.
    def new
        @article = Article.new()
    end
    
    def create
        # render plain: params[:article].inspect
        # @article.save
        # redirect_to articles_path(@article)

        # Creates a new Article object
        @article = Article.new(article_params)

        # Handles if Articles saves or not based on the validations on the model.
        if @article.save
            # If article saves then redirect to the article with a message.
            flash[:notice] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            # If article does not save the re render the new article page. Errors displayed and handled on the new.html.erb
            render :new
        end
    end

    def show
        # Shows a specific record or article in this case. based on the id.
        @article = Article.find(params[:id])
    end

    private
    def article_params
        # params.requires(:toplevelkey).permit(:secondlevelone, :secondleveltwo)
        params.require(:article).permit(:title, :description)
    end

end