class CategoriesController < ApplicationController

    # ---------------------------------------------> CATEGORIES CONTROLLER. <--------------------------------------------------

    # --------------------------------------------- BEFORE ACTIONS sections. --------------------------------------------------

    before_action :require_admin, except: [:index, :show]
    before_action :found_category, only: [:show, :edit, :update]

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- INDEX. -------------------------------------------------

    def index
        @categories = Category.paginate(page: params[:page], per_page: 3) # <-- Pagination cinfiguration. 3 is the amount of objects displayed in the views.
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- SHOW. -------------------------------------------------

    def show
        # @category = Category.find(params[:id])
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- NEW. -------------------------------------------------

    def new
        @category = Category.new()
    
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- CREATE. -------------------------------------------------

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category, notice: "Category successfully created."
        else
            render :new, status: :unprocessable_entity
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- EDIT. -------------------------------------------------

    def edit
        # @category = Category.find(params[:id])
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- UPDATE. -------------------------------------------------

    def update
        # @category = Category.find(params[:id])
        
        if @category.update(category_params)
            redirect_to @category, notice: "Category update successfully."
        else
            render :edti, status: :unprocessable_entity
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- PRIVATE methods. -------------------------------------------------

    private
        def category_params # <--- Categories' params.
            params.require(:category).permit(:name)
        end

        def found_category # <--- Same action for several methods.
            @category = Category.find(params[:id])
        end

        def require_admin # <--- This method requires an admin.
            if !(logged_in?)
                redirect_to login_path, notice: "You must be login."
            elsif !(logged_in? && current_user.admin?)
                redirect_to categories_path, notice: "Only admins can add categories."
            end
        end
end
