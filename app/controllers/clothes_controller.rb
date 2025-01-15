class ClothesController < ApplicationController
  def index
    @clothes = current_user.clothes.includes(:clothing_usage_logs)
  end

  def new
    @cloth = Cloth.new
  end

  def create
    @cloth = current_user.clothes.new(cloth_params)

    if @cloth.save
      redirect_to clothes_path, notice: "登録しました"
    else
      Rails.logger.debug(@cloth.errors.full_messages)
      render :new
    end
  end

  def usage_log
    @cloth = current_user.clothes.find(params[:id])
    ClothingUsageLog.create!(cloth: @cloth, user: current_user, used_at: Time.current)

    redirect_to clothes_path, notice: "使用記録を追加しました"
  end

  private

  def cloth_params
    params.require(:cloth).permit(:name, :category_id, :brand_id, :color_id, :explanation, :image)
  end
end
