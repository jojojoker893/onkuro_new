class ClothingUsageGraph
  def initialize(user:, start_date:, end_date:)
    @user = user
    @start_date = start_date
    @end_date = end_date
  end

  def call
    usage_data = usage_data_range_or_all
    usage_data
    .select { |name, count| count.positive? }
    .map { |name, count| { name: name, y: count } }
  end

  private

  attr_reader :user, :start_date, :end_date

  def usage_data_range_or_all
    user.clothings.map do |clothing|
      all_usage_logs = clothing.clothing_usage_logs
      all_reduced_logs = clothing.usage_log_clearing

      if start_date.present? && end_date.present?
        usage_logs = all_usage_logs.where(used_at: start_date.beginning_of_day..end_date.end_of_day)
        reduced_logs = all_reduced_logs.where(reduced_at: start_date.beginning_of_day..end_date.end_of_day)
        count = [ usage_logs.count - reduced_logs.count, 0 ].max
      else
        count = clothing.usage_total_count
      end

      [ clothing.name, count ]
    end
  end
end
