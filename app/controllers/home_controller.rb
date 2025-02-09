class HomeController < ApplicationController
  def index 
    @use_logs = current_user.clothing
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
      .map { |name, count| [ name, count ] }
      .sort_by { |_, count| -count }
  end

  def clothes_sum # 服の総量 表示されない
    @total_clothings = current_user.count(:clothing).to_i
  end
end
