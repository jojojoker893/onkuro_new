class GraphController < ApplicationController
  def index
    startdate = Date.parse(params[:start_date]) rescue nil
    enddate = Date.parse(params[:end_date]) rescue nil

    if startdate.present? && enddate.present?
      usage_data = ClothingUsageLog.usage_period(startdate, enddate)
    else
      usage_data = current_user.clothing
        .joins(:clothing_usage_logs)
        .group("clothings.id")
        .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
    end

    @graph_data = usage_data.map { |name, count| { name: name, y: count } }
  end
end
