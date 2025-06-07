class ClothingsController < ApplicationController
  def index
    @categories = Category.all
    @brands = Brand.all
    @colors = Color.all
    @clothings = ClothingReport.new(user_id: current_user.id, params: params).call
  end

  def new
    @clothing = Clothing.new
  end

  def create
    @clothing = current_user.clothings.new(clothing_params)

    if @clothing.save
      redirect_to clothings_path, notice: "登録しました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @clothing = Clothing.find(params[:id])
  end

  def update
    @clothing = Clothing.find(params[:id])
    if @clothing.update(clothing_params)
      redirect_to clothings_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @clothing = Clothing.find(params[:id])
    @clothing.destroy
    redirect_to clothings_path, notice: "削除しました"
  end

  def usage_log # 使用回数の記録
    if RecordUsageLogAdder.new(user: current_user, clothing_id: params[:id]).call
      redirect_to clothings_path, notice: "使用記録を追加しました"
    else
      redirect_to clothings_path, alert: "使用記録を追加できませんでした"
    end
  end

  def remove_usage_log # 使用回数を減らす
    if RecordUsageLogRemover.new(user: current_user, clothing_id: params[:id]).call
      redirect_to clothings_path, notice: "使用記録を減らしました"
    else
      redirect_to clothings_path, alert: "使用記録がありません"
    end
  end

  private

  def clothing_params
    params.require(:clothing).permit(:name, :category_id, :brand_id, :color_id, :explanation, :image, :order, :keyword)
  end
end
