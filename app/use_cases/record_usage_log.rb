class RecordUsageLog
  def initialize(user:, clothing_id:)
    @user = user
    @clothing_id = clothing_id
  end


  def add # 使用回数の記録
    clothing = @user.clothings.find_by(id: @clothing_id)
    return false unless clothing

    usege_log = ClothingUsageLog.create(
      user: @user,
      clothing: clothing,
      used_at: Time.current
    )

    usege_log
  end

  def remove # 使用回数を減らす
    clothing = @user.clothings.find_by(id: @clothing_id)
    return false unless clothing

    log = ClothingUsageLog.where(user: @user, clothing: clothing)
    .order(used_at: :desc).first

    return false unless log

    log.destroy
  end
end
