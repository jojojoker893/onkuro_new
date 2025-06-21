require 'rails_helper'
RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }

  before do # ログイン状態の作成
    post "/login", params: {
      session: {
        email: user.email,
        password: user.password
      }
    }
    end

  describe "GET /graph" do
    context "ログインユーザーがグラフページを表示した時" do
      it "グラフページのリクエストが200OKであること" do
        get graph_path
        expect(response).to have_http_status(:ok)
      end
    end

    context "日付のパラメータを指定した時" do
      it "指定した期間のデータが取得されること" do
        get graph_path, params: {
          start_date: "2025-05-01",
          end_date: "2025-05-31"
        }
        expect(response).to have_http_status(:ok)
      end
    end

    context "日付のパラメータがnilの時" do
      it "正常動作すること" do
        get graph_path, params: {
          start_date: nil,
          end_date: nil
        }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
