class PagesController < ApplicationController

    # ---------------------------------------------> PAGES CONTROLLER. <--------------------------------------------------

    # --------------------------------------------- HOME. --------------------------------------------------

  def home # <--- If there's a user logged in, once he try to go to home, he will be redirect to articles path.
    redirect_to articles_path if logged_in?
  end
end