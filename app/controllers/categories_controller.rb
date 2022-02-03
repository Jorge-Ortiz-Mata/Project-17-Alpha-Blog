class CategoriesController < ApplicationController

    before_action :require_admin, except: [:index, :show]

    def index
        @categories = Category.paginate(page: params[:page], per_page: 3) # <-- Pagination cinfiguration. 3 is the amount of objects displayed in the views.
    end


    def show
        @category = Category.find(params[:id])
    end


    def new
        @category = Category.new()
    
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category, notice: "Category successfully created."
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
        def category_params
            params.require(:category).permit(:name)
        end

        def require_admin
            if !(logged_in?)
                redirect_to login_path, notice: "You must be login."
            elsif !(logged_in? && current_user.admin?)
                redirect_to categories_path, notice: "Only admins can add categories."
            end
        end
end
