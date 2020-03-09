class ArticlesController < ApplicationController

    # @ specifies an instance varible.
    # @ here it is being set to a new Article object.
    def new
        @article = Article.new()
    end
    
    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.save
        redirect_to articles_show(@article)
    end

    private
    def article_params
        # params.requires(:toplevelkey).permit(:secondlevelone, :secondleveltwo)
        params.require(:article).permit(:title, :description)
    end

end