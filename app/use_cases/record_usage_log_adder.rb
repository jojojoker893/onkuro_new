class RecordUsageLogAdder
  def initialize(user:, clothing_id:)
    @user = user
    @clothing_id = clothing_id
  end

  def call # 使用回数の記録
    clothing = user.clothings.find_by(id: clothing_id)
    return false unless clothing

    usage_log = ClothingUsageLog.create(
      user: user,
      clothing: clothing,
      used_at: Time.current
    )

    usage_log
  end

  private

  attr_reader :user, :clothing_id
end
