class PasswordUpdater # current_userのパスワードを更新するクラス
  def initialize(current_user, current_password, new_params)
    @user = current_user
    @current_password = current_password
    @new_params = new_params
  end

  def call
    return false unless valid_password?

    current_password_update
  end

private

attr_reader :user, :current_password, :new_params

  def valid_password?
    user.authenticate(current_password)
  end

  def current_password_update
    user.update(new_params)
  end
end
