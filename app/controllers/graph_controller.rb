class GraphController < ApplicationController
  before_action :login_user?
  def index
    start_date = GraphDataParseTime.new(params[:start_date]).call
    end_date = GraphDataParseTime.new(params[:end_date]).call

    @graph_data = ClothingUsageGraph.new(
      user: current_user,
      start_date: start_date,
      end_date: end_date
    ).call
  end
end
