class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end
