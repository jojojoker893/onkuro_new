class HomeController < ApplicationController
  def index # モデルに書いてもいいかな
    @use_logs = current_user.clothes
      .includes(:clothing_usage_logs)
      .group("cloths.id")
      .pluck("cloths.name, COUNT(clothing_usage_logs.id)")
      .to_h
  end

  def clothes_sum # 服の総量 表示されない
    @total_clothes = current_user.count(:clothes).to_i
  end
end
