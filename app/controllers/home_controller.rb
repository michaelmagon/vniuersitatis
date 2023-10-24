class HomeController < ApplicationController
  def index
    redirect_to courses_list_url if user_signed_in?  
  end
end
