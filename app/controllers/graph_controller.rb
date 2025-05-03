class GraphController < ApplicationController
  def index
    startdate = Time.zone.parse(params[:start_date]) rescue nil
    enddate = Time.zone.parse(params[:end_date]) rescue nil

    @graph_data = ClothingUsageGraph.new(
      user: current_user,
      startdate: startdate,
      enddate: enddate
    ).call
  end
end
