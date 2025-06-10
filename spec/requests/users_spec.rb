require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:valid_password) { "password" }
  let(:new_password) { "password_new" }

  describe "GET /users/new" do
    context "ユーザー登録画面の表示をした時" do
      it "ユーザー登録画面へのリクエストが200OKであること" do
        get new_user_path
        expect(response).to have_http_status (:ok)
      end
    end
  end

  describe "POST /users" do
    context "正しいパラメータを送信した時" do
      it "ユーザーが作成されログインページへリダイレクトすること" do
        expect {
          post "/users", params: {
            user: {
              name: "test_user",
              email: "test@example.com",
              password: "valid_password",
              password_confirmation: "valid_password"
            }
          }
        }.to change(User, :count).by(1)
        expect(response).to redirect_to login_path
      end
    end
  end
end
