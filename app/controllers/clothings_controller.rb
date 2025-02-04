class ClothingsController < ApplicationController
  def index
    @clothings = current_user.clothing.includes(:clothing_usage_logs)
  end

  def new
    @clothing = Clothing.new
  end

  def create
    @clothing = current_user.clothing.new(clothing_params)

    if @clothing.save
      redirect_to clothings_path, notice: "登録しました"
    else
      Rails.logger.debug(@clothing.errors.full_messages)
      render :new
    end
  end

  def edit
    @cloth = Clothing.find(params[:id])
  end

  def update
    @clothing = Clothing.find(params[:id])
    if @clothing.update(clothing_params)
      redirect_to clothings_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @clothing = Clothing.find(params[:id])
    @clothing.destroy
    redirect_to clothings_path, notice: "削除しました"
  end

  def usage_log
    @clothing = current_user.clothing.find(params[:id])
    ClothingUsageLog.create!(clothing: @clothing, user: current_user, used_at: Time.current)

    redirect_to clothings_path, notice: "使用記録を追加しました"
  end

  def usage_order
    @usage_count_log = current_user.clothing
    .includes(:clothing_usage_logs)
    .joins(clothing_usage_logs)
    .order("clothing_usage_logs.used_at: :DESC")
  end

  private

  def clothing_params
    params.require(:clothing).permit(:name, :category_id, :brand_id, :color_id, :explanation, :image)
  end
end
