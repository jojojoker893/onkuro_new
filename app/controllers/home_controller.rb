class HomeController < ApplicationController
  def index
    @use_logs = current_user.clothes
      .joins(:clothing_usage_logs)
      .group("cloths.id")
      .pluck("cloths.name, COUNT(clothing_usage_logs.id)")
      .to_h
  end
end
