class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user
  # TODO: ActiveRecord::RecordNotFoundをrescue_fromして、404ページに遷移させる

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
