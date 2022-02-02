class SessionsController < ApplicationController

    # ---------------------------------------------> SESSIONS CONTROLLER. <--------------------------------------------------

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- NEW. -------------------------------------------------

    def new
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- CREATE. -------------------------------------------------

    def create
        user = User.find_by(email: params[:session][:email].downcase) # <--- It converts the email into downcase string.
    
        if user && user.authenticate(params[:session][:password])   # <--- If the user logged_in succesfully.
            session[:user_id] = user.id                             # <-- Save the user into the session.
            redirect_to user, notice: "Successfully loged in."
        else
            redirect_to login_path, notice: "Invalid parmas."
        end
    end

    # ------------------------------------------------------------------------------------------------------
    # --------------------------------------------- DESTROY. -------------------------------------------------

    def destroy
        session[:user_id] = nil # <---- Destroy the user by assigning nil.
        redirect_to root_path, notice: "Logged out."
    end

    # ------------------------------------------------------------------------------------------------------
end