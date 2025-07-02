class GraphController < ApplicationController
  def index
    start_date = parse_time(params[:start_date])
    end_date = parse_time(params[:end_date])

    @graph_data = ClothingUsageGraph.new(
      user: current_user,
      start_date: start_date,
      end_date: end_date
    ).call
  end

  private

  def parse_time(date)
    return nil if date.blank?

    Time.zone.parse(date)
  rescue ArgumentError
    nil
  end

  def remove_usage_log
    form = UsageLogClearing::CreateForm.new(clothing: user.clothings.find(params[:id]))
    result = form.save
    if result.success?
      redirect_to clothings_path, notice: "使用記録を減らしました"
    else
      redirect_to clothings_path, alert: result.error_message
    end
  end
end
