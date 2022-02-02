class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update, :destroy]
    before_action :same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.all
    end
    def show
        # @user = User.find(params[:id]) <--- This line repeats in several methods.
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(params_user)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "User signed in successfully."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        # @user = User.find(params[:id]) <--- This line repeats in several methods.
    end

    def update
        # @user = User.find(params[:id]) <--- This line repeats in several methods.

        if @user.update(params_user)
            redirect_to @user, notice: "Account was updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil if (current_user == @user)
        @user.destroy
        redirect_to users_path, notice: "Account and articles are deleted."
    end

    private
        
        def set_user
            @user = User.find(params[:id])
        end

        def same_user
            if !current_user.admin? && (current_user != @user)
            redirect_to users_path, notice: "You are not allowed to do this."
            end
        end

        def params_user # <-- Method with all the article params.
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end
end