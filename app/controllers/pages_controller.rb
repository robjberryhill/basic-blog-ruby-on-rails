class PagesController < ApplicationController
  # The home page of the whole app is routed to this method. app/views/pages/home.html.erb
  def home
    # If user is logged in the redirect to the articles page app/views/articles/index.html.erb instead of the home page.
    redirect_to articles_path if logged_in?
  end

  def about
  end
end
