class HomeController < ApplicationController
  def index
    @clothes_data = current_user.clothes
  end
end
