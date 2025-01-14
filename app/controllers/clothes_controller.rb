class ClothesController < ApplicationController
  def index
    @clothes = Cloth.all
  end

  def new
    @cloth = Cloth.new
  end

  def create
    @cloth = Cloth.new(cloth_params)

    if @cloth.save
      redirect_to clothes_path, notice: "登録しました"
    else
      render :new
    end
  end

  private

  def cloth_params
    params.require(:cloth).permit(:name, :category_id, :brand_id, :color_id, :explanation, :user_id)
  end
end
