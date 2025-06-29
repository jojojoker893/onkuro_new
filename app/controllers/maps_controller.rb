class MapsController < ApplicationController
  before_action :login_user?
  def index
    @google_maps_api_key = get_google_maps_api_key
  end


  private

  def login_user?
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end

  def get_google_maps_api_key
    if Rails.env.production?
      Rails.application.credentials.dig(:google_maps, :GOOGLE_MAPS_API_KEY)
    else
      ENV["GOOGLE_MAPS_API_KEY"]
    end
  end
end
