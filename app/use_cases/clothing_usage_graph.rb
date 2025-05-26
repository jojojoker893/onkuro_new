class ClothingUsageGraph
  def initialize(user:, start_date:, end_date:)
    @user = user
    @start_date = start_date
    @end_date = end_date
  end

  def call
    usage_data = usage_data_range_or_all
    usage_data.map { |name, count| { name: name, y: count } }
  end

  private

  attr_reader :user, :start_date, :end_date

  def usage_data_range_or_all
    if start_date.present? && end_date.present?
      # 両方の日付が指定されている場合は、その期間に絞って使用回数を取得
      ClothingUsageLog.usage_period(user.id, start_date, end_date)
    else
      # 日付が未指定なら、全ての服のログ使用ログを集計(服のIDごとにグループ化)
      user.clothings
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
    end
  end
end
