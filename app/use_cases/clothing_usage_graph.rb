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
      ClothingUsageLog.usage_period(user.id, start_date, end_date)
    else
      user.clothings
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
    end
  end
end
