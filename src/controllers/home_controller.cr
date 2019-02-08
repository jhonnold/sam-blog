class HomeController < ApplicationController
  def about
    render "about.ecr"
  end

  def contact
    render "contact.ecr"
  end

  def login
    if params[:password] == ENV["BLOG_PASSWORD"]
      session[:logged_in] = true
    else
      flash[:error] = "Incorrect password!"
    end
    redirect_to "/"
  end

  def logout
    session[:logged_in] = nil
    redirect_to "/"
  end
end
