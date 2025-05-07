class ClothingUsageGraph
  attr_reader :user, :start_date, :end_date

  def initialize(user:, start_date:, end_date:)
    @user = user
    @start_date = start_date
    @end_date = end_date
  end

  def call
    if start_date.present? && end_date.present?
      usage_data = ClothingUsageLog.usage_period(user.id, start_date, end_date)
    else
      usage_data = user.clothings
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
    end
    usage_data.map { |name, count| { name: name, y: count } }
  end
end
