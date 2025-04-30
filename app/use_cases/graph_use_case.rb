class GraphUseCase
  def initialize(user:, startdate:, enddate:)
    @user = user
    @startdate = startdate
    @startdate = enddate
  end

  def call
    if @startdate.present? && @enddate.present?
      usage_data = ClothingUsageLog.usage_period(current_user, startdate, enddate)
    else
      usage_data = @user.clothings
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
    end
    usage_data.map { |name, count| { name: name, y: count } }
  end
end
