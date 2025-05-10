class GraphController < ApplicationController
  def index
    start_date = Time.zone.parse(params[:start_date]) rescue nil
    end_date = Time.zone.parse(params[:end_date]) rescue nil

    @graph_data = ClothingUsageGraph.new(
      user: current_user,
      start_date: start_date,
      end_date: end_date
    ).call
  end
end
