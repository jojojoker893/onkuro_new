class RecordUsageLogRemover
  def initialize(user:, clothing_id:)
    @user = user
    @clothing_id = clothing_id
  end

  def call # 使用を取り消した履歴を残す
    clothing = user.clothings.find_by(id: clothing_id)
    return false unless clothing

    # 使用回数ログより減少ログが多くならないようにする
    usage_log_count = clothing.clothing_usage_logs.count
    reduced_log_count = clothing.usage_log_clearing.count

    if usage_log_count > reduced_log_count
        reduced_log = UsageLogClearing.create(
          user: user,
          clothing: clothing,
          reduced_at: Time.current
        )

    reduced_log

    else
      false
    end
  end

  private

  attr_reader :user, :clothing_id
end
