require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:valid_password) { "password" }
  let(:new_password) { "password_new" }

  context "正しいパラメータでユーザー登録する場合" do # AAAに乗っ取り準備段階 before
    let(:user_params) {
      {
        name: "test_user",
        email: "test@example.com",
        password: "valid_password",
        password_confirmation: "valid_password"
      }
    }
    it "ユーザーが作成されること" do
      post "/users", params: { user: user_params }
      expect(response).to redirect_to(login_path)
    end
  end
end
