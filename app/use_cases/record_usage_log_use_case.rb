class RecordUsageLogUseCase
  def initialize(user:, clothing_id:)
    @user = user
    @clothing_id = clothing_id
  end

  def add # 使用回数の記録
    ClothingUsageLog.usage_log(user: @user, clothing_id: @clothing_id)
  end

  def remove # 使用回数を減らす
    ClothingUsageLog.remove_usage_log(user: @user, clothing_id: @clothing_id)
  end
end
