class HomeController < ApplicationController
  def index 
    @use_logs = current_user.clothing
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
      .map { |name, count| [ name, count ] }
      .sort_by { |_, count| -count }
  end

end
