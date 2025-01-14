class ClothesController < ApplicationController
  def index
    @clothes = current_user.clothes
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

  private

  def cloth_params
    params.require(:cloth).permit(:name, :category_id, :brand_id, :color_id, :explanation, :image)
  end
end
