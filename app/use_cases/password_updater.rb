class PasswordUpdater
  def initialize(user, current_password:, new_params:)
    @user = user
    @current_password = current_password
    @new_params = new_params
  end

  def call
    update_current_password
  end

  private
  attr_reader :user, :current_password, :new_params

  def update_current_password
    if user.authenticate(current_password)
      user.update(new_params)
    else
      user.errors.add(:current_password, "が正しくありません")
      false
    end
  end
end
