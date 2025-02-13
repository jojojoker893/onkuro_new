class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録しました"
      redirect_to login_path
    else
      if @user.errors[:email].include?("has already been taken")
        flash.now[:alert] = "このメールアドレスは既に使用されています"
      else
        flash.now[:alert] = "登録に失敗しました"
      end
        render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
