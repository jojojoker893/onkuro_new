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

    def show
    end

    def edit
      @user = current_user
    end

    def destroy
      current_user.destroy
      reset_session
      flash[:notice] = "アカウントを削除しました"
      redirect_to root_path
    end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password)
  end
end
