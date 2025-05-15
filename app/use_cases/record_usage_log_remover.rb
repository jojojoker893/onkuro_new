class RecordUsageLogRemover
  def initialize(user:, clothing_id:)
    @user = user
    @clothing_id = clothing_id
  end

  def call # 使用回数を減らす
    clothing = user.clothings.find_by(id: clothing_id)
    return false unless clothing

    log = ClothingUsageLog.where(user: user, clothing: clothing)
    .order(used_at: :desc).first

    return false unless log

    log.destroy
  end

  private

  attr_reader :user, :clothing_id
end
