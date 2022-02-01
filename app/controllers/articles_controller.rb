class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy] # <----- Before the action, execute the function set_article only for this methods.
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        # @articles = Article.all <-- This was removed in order to include pagination functionality.
        @articles = Article.paginate(page: params[:page], per_page: 3)
    end

    def show
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(params_article)
        @article.user = current_user

        if @article.save
            redirect_to articles_path, notice: "Article saved successfully."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.v
    end

    def update
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.

        if @article.update(params_article)
            redirect_to @article, notice: "Article updated successfully."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.
        @article.destroy
        redirect_to articles_path, notice: "Article deleted."
    end

    private

        def set_article # <-- Method created and setup at the top of the file using a before action.
            @article = Article.find(params[:id])
        end

        def params_article # <-- Method with all the article params.
            params.require(:article).permit(:title, :description)
        end

        def require_same_user
            if current_user != @article.user
                redirect_to articles_path, notice: "This article doesn't belong to you."
            end
        end

end
