class UsersController < ApplicationController

    # ---------------------------------------------> USERS CONTROLLER. <--------------------------------------------------

    # --------------------------------------------- BEFORE ACTIONS sections. -------------------------------------------------

    before_action :set_user, only: [:show, :edit, :update, :destroy]    # <--- Same code for several methods.
    before_action :require_user, only: [:edit, :update, :destroy]       # <---- In order to edit, update or destroy a user, the must be logged in.
    before_action :same_user, only: [:edit, :update, :destroy]    # <---- In order to edit, update or destroy a user, must be the same user.

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- INDEX. -------------------------------------------------

    def index
        @users = User.all
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- SHOW. -------------------------------------------------

    def show
        # @user = User.find(params[:id]) <--- This line repeats in several methods.
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- NEW. -------------------------------------------------

    def new
        @user = User.new
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- CREATE. -------------------------------------------------

    def create
        @user = User.new(params_user)
        if @user.save
            session[:user_id] = @user.id # <--- Once we create a user, it will automatically be logged in.
            redirect_to root_path, notice: "User signed in successfully."
        else
            render :new, status: :unprocessable_entity
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- EDIT. -------------------------------------------------

    def edit
        # @user = User.find(params[:id]) <--- This line repeats in several methods.
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- UPDATE. -------------------------------------------------

    def update
        # @user = User.find(params[:id]) <--- This line repeats in several methods.

        if @user.update(params_user)
            redirect_to @user, notice: "Account was updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- DESTROY. -------------------------------------------------

    def destroy
        session[:user_id] = nil if (current_user == @user) # <--- This line will not be execute if the admin delte a user. It keeps the session open.
        @user.destroy
        redirect_to users_path, status: :see_other
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- PRIVATE Methods. -------------------------------------------------

    private
        
        def set_user # <-- Method created and setup at the top of the file using a before action because this line repeats en several methods.
            @user = User.find(params[:id])
        end

        def same_user # <-- If the current user logged in is an admin, he can edit, update or delete others users. 
            if !current_user.admin? && (current_user != @user)
            redirect_to users_path, notice: "You are not allowed to do this."
            end
        end

        def params_user # <-- Method with all the article params.
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end
end