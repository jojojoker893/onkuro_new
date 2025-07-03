class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_user?
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
