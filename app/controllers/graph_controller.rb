class GraphController < ApplicationController
  before_action :login_user?
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

  def login_user?
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
