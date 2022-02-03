class ArticlesController < ApplicationController

    # ---------------------------------------------> ARTICLES CONTROLLER. <--------------------------------------------------

    # --------------------------------------------- BEFORE ACTIONS sections. --------------------------------------------------

    before_action :set_article, only: [:show, :edit, :update, :destroy] # <----- Before the action, execute the function set_article only for this methods.
    before_action :require_user, except: [:index, :show] # <------ It requires a user except on this webpage.
    before_action :require_same_user, only: [:edit, :update, :destroy] # <------ This action will be execute if the user is authenticate.

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- INDEX. -------------------------------------------------

    def index
        # @articles = Article.all <-- This was removed in order to include pagination functionality.
        @articles = Article.paginate(page: params[:page], per_page: 3) # <-- Pagination cinfiguration. 3 is the amount of objects displayed in the views.
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- SHOW. -------------------------------------------------

    def show
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.
    end
    
    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- NEW. -------------------------------------------------

    def new
        @article = Article.new
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- CREATE. -------------------------------------------------

    def create
        @article = Article.new(params_article) # <-- Save the article with these params.
        @article.user = current_user # <--- If the user create an article, automatically it will be save into the user's articles.

        if @article.save 
            redirect_to articles_path, notice: "Article saved successfully."
        else
            render :new, status: :unprocessable_entity
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- EDIT. -------------------------------------------------

    def edit
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.v
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- UPDATE. -------------------------------------------------

    def update
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.

        if @article.update(params_article)
            redirect_to @article, notice: "Article updated successfully."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- DESTROY. -------------------------------------------------

    def destroy
        # @article = Article.find(params[:id]) <--- We delete this because it repeats several times. We create a method inside of private section.
        @article.destroy
        redirect_to articles_path, status: :see_other
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- PRIVATE methods. -------------------------------------------------

    private

        def set_article # <-- Method created and setup at the top of the file using a before action because this line repeats en several methods.
            @article = Article.find(params[:id])
        end

        def params_article # <-- Method with all the article params.
            params.require(:article).permit(:title, :description, category_ids: [])
        end

        def require_same_user # <---- It requires a user in order to edit, update or destroy a user.
            if !current_user.admin? && (current_user != @article.user)
                redirect_to articles_path, notice: "This article doesn't belong to you."
            end
        end
end
