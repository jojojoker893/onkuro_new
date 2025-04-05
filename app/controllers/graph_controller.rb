class GraphController < ApplicationController
  def index
    startdate = Time.zone.parse(params[:startdate]) rescue nil
    enddate = Time.zone.parse(params[:enddate]) rescue nil

    if startdate.present? && enddate.present?
      usage_data = ClothingUsageLog.usage_period(current_user, startdate, enddate)
      @graph_data = usage_data.map { |name, count| { name: name, y: count } }
    else
      usage_data = current_user.clothing
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
      @graph_data = usage_data.map { |name, count| { name: name, y: count } }
    end
  end
end
