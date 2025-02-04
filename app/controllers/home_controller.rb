class HomeController < ApplicationController
  def index # モデルに書いてもいいかな
    @use_logs = current_user.clothing
      .includes(:clothing_usage_logs)
      .group("clothing.id")
      .pluck("clothing.name, COUNT(clothing_usage_logs.id)")
      .to_h
  end

  def clothes_sum # 服の総量 表示されない
    @total_clothes = current_user.count(:clothing).to_i
  end
end
