require 'rails_helper'

RSpec.describe "Clothings", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:brand) { create(:brand) }
  let!(:color) { create(:color) }
  let!(:clothing) { create(:clothing, user: user, category: category, brand: brand, color: color) }

  before do # ログイン状態の作成
    post "/login", params: {
      session: {
        email: user.email,
        password: user.password
      }
    }
    end

  describe "GET /clothings" do
    context "ログインユーザーが一覧ページの表示をした時" do
      it "一覧ページへのリクエストが200OKであること" do
        get clothings_path
        expect(response).to have_http_status(:ok)
      end

      it "自分の服のみ表示されること" do
        get clothings_path
        expect(response.body).to include(clothing.name)
      end
    end
  end

  describe "GET /clothings/new" do
    context "新規作成ページを表示した時" do
      it "新規作成ページへのリクエストが200OKであること" do
        get new_clothing_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /clothings" do
    context "正しいパラメーターを送信した時" do
      it "服が新規登録され一覧ページへリダイレクトすること" do
        expect {
          post "/clothings", params: {
            clothing: {
              name: "new_clothing",
              category_id: category.id,
              brand_id: brand.id,
              color_id: color.id
            }
          }
        }.to change(Clothing, :count).by(1)
        expect(response).to redirect_to clothings_path
      end
    end

    context "不正なパラメータを送信した時" do
      it "登録が失敗すること" do
        expect {
          post "/clothings", params: {
            clothing: {
              name: "failure_clothing",
              category_id: nil,
              brand_id: nil,
              color_id: nil
            }
          }
        }.not_to change(Clothing, :count)
      end
    end
  end

  describe "GET /clothings/:id" do
    context "服の詳細ページ表示した時" do
      it "詳細ページへのリクエストが200OKであること" do
        get edit_clothing_path(clothing.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH /clothings/:id" do
    context "正しいパラメーターを送信した時" do
      it "登録情報が正しく更新されること" do
        patch clothing_path(clothing), params: {
          clothing: {
            name: "update_clothing",
            category_id: category.id,
            brand_id: brand.id,
            color_id: color.id
          }
        }
        expect(clothing.reload.name).to eq "update_clothing"
      end
    end

    context "不正なパラメーターを送信した時" do
      it "更新が失敗すること" do
        expect {
          patch clothing_path(clothing), params: {
            clothing: {
              name: "not_update_clothing",
              category_id: nil,
              brand_id: nil,
              color_id: nil
            }
          }
        }.not_to change { clothing.reload.name }
        expect(response.body).to include ("更新に失敗しました")
      end
    end
  end

  describe "DELETE /clothings/:id" do
    context "服の削除をした時" do
      it "レコードが1件減り一覧ページへリダイレクトすること" do
        expect {
          delete clothing_path(clothing.id)
        }.to change(Clothing, :count).by(-1)

        expect(response).to redirect_to clothings_path
      end
    end
  end

  describe "POST /clothings/:id/usage_log" do
    context "服の記録を追加した場合" do
      it "正常に使用回数が増えること" do
        expect {
          post usage_log_clothing_path(clothing.id)
      }.to change(ClothingUsageLog, :count).by(1)

        expect(response).to redirect_to clothings_path
        follow_redirect!
        expect(response.body).to include("使用記録を追加しました")
      end
    end

    context "使用の記録が失敗した場合" do
      before do
        usage_log_mock = double(ClothingUsageLog, save: false)
        allow(ClothingUsageLog).to receive(:new).and_return(usage_log_mock)
      end
      it "使用記録が追加されないこと" do
        post usage_log_clothing_path(clothing.id)
        expect(response).to redirect_to clothings_path
        follow_redirect!
        expect(response.body).to include("使用記録を追加できませんでした")
      end
    end
  end

  describe "POST /clothing/:id/remove_usage_log" do
    context "服の記録を減らした場合" do
      let!(:usage_log) { create(:clothing_usage_log, user: user, clothing: clothing) }

      it "正常に使用回数が減ること" do
        expect { post remove_usage_log_clothing_path(clothing.id)
          }.to change(UsageLogClearing, :count).by(1)

        expect(response).to redirect_to clothings_path
        follow_redirect!
        expect(response.body).to include("使用記録を減らしました")
      end
    end

    context "使用の取り消しが失敗した場合" do
      it "使用記録が減らないこと" do
        expect { post remove_usage_log_clothing_path(clothing.id)
          }.to change(UsageLogClearing, :count).by(0)

        expect(response).to redirect_to clothings_path
        follow_redirect!
        expect(response.body).to include("使用回数をこれ以上減らせません")
      end
    end
  end
end
