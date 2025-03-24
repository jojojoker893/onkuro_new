class GraphController < ApplicationController
  def index
    @use_logs = current_user.clothing
      .joins(:clothing_usage_logs)
      .group("clothings.id")
      .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
      .map { |name, count| { name: name, y: count } }
  end
end
