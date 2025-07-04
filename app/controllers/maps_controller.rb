class MapsController < ApplicationController
  before_action :login_user?
  def index
    @google_maps_api_key = get_google_maps_api_key
  end


  private

  def get_google_maps_api_key
    if Rails.env.production?
      Rails.application.credentials.dig(:google_maps, :GOOGLE_MAPS_API_KEY)
    else
      ENV["GOOGLE_MAPS_API_KEY"]
    end
  end
end
