require 'rails_helper'
RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }

  describe "POST /login" do
    context "正しいパラメータを送信した時" do
      it "ログインできること" do
        post "/login", params: {
          session: {
            email: user.email,
            password: "sample_password"
          }
        }

        expect(response).to redirect_to graph_path
        follow_redirect!
        expect(response.body).to include("ログインしました")
      end
    end

    context "不正なパラメータを送信した時" do
      it "ログインできないこと" do
        post "/login", params: {
          session: {
            email: user.email,
            password: "miss_password"
          }
        }

        expect(response).to have_http_status (:unprocessable_entity)
        expect(response.body).to include("メールアドレスまたはパスワードが正しくありません")
      end
    end
  end

  describe "DELETE /logout" do
    context "ログアウトをした時" do
      it "セッションが削除されroot_pathへリダイレクトすること" do
        # ログイン状態の作成
        post "/login", params: {
          session: {
            email: user.email,
            password: "sample_password"
          }
        }

        delete "/logout"

        expect(response).to redirect_to root_path
        follow_redirect!
        expect(response.body).to include "ログアウトしました"
      end
    end
  end
end
