require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user) { create(:user, email: "test@example.com", password: "sample_password") }

# ログインした後にパスワードの検証
  context "正しいログイン情報でログインして" do
    it "パスワードが変更されること" do
      post "/login", params: {
        session: {
          email: "test@example.com",
          password: "sample_password"
        }
      }
      expect(response).to redirect_to(graph_path)

      patch "/user/password", params: {
        user: {
          current_password: "sample_password",
          password: "sample_password_new",
          password_confirmation: "sample_password_new"
        }
      }
    expect(response).to redirect_to(edit_password_user_path)

    post "/login", params: {
        session: {
          email: "test@example.com",
          password: "sample_password_new"
        }
      }
      expect(response).to redirect_to(graph_path)
    end
  end
end
