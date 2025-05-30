require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, password: "password") }

  before do
    session[:user_id] = user.id
  end

  context "現在のパスワードを入力した場合" do
    it "パスワードが更新される" do
      patch :password_update, params: {
        user: {
          current_password: "password",
          password: "new_password",
          password_confirmation: "new_password"
        }
      }

      expect(response).to redirect_to edit_password_user_path
      expect(flash[:notice]).to eq("パスワードを変更しました")
    end
  end

  context "#new" do
    it "正常にレスポンスを返すこと" do
      get :new
      expect(response).to be_successful
    end

    it "200レスポンスを返すこと" do
      get :new
      expect(response).to have_http_status "200"
    end
  end
end
