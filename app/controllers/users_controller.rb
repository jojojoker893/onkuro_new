class UsersController < ApplicationController
  before_action :login_user?, except: [ :new, :create ]
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
      flash.now[:alert] = "登録に失敗しました, #{@user.errors.full_messages.to_sentence}"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to user_path
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def password_update
    @user = current_user
    updated_password = PasswordUpdater.new(current_user, params[:user][:current_password], password_params)

    if updated_password.call
      flash[:notice] = "パスワードを変更しました"
      redirect_to edit_password_user_path
    else
      flash.now[:alert] = "変更に失敗しました"
      render :edit_password, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def destroy
    current_user.destroy
    reset_session
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path
  end

  def unsubscribe
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
