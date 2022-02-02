class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in? # <---- This methods will be execute in helper folder.

    # -------------------------------------- current_user method. -----------------------------------
=begin 
    This method was developed in order to avoid a continuos searching trough all the users.
    Once we found the session_id, it will be saved in @current_user when we want to visit another page.
    It's more efficient. 
=end
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    # -------------------------------------- logged_in? method. -----------------------------------
=begin
    logged_in? will be either true or false depending on @current_user status.
    We use !! symbols to configure current_user status response.
=end
    def logged_in?
        !!current_user
    end

    # -------------------------------------- require_user method. -----------------------------------

=begin
    This method will be execute when the user tries to create, edit, update or destroy an article.
    If the user is not logged_in, he will be redirect to login path.
=end

    def require_user
        if !logged_in?
            redirect_to login_path, notice: "You should login first."
        end
    end
end
