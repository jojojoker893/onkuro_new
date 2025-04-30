class GraphController < ApplicationController
  def index
    startdate = Time.zone.parse(params[:startdate]) rescue nil
    enddate = Time.zone.parse(params[:enddate]) rescue nil

    @graph_data = GraphUseCase.new(
      user: current_user,
      startdate: startdate,
      enddate: enddate
    ).call
  end
end
