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

  context "一覧ページの表示" do
    it "一覧ページへのリクエストが200OKであること" do
      get clothings_path
      expect(response.status).to eq 200
    end

    it "自分の服のみ表示されること" do
      get clothings_path
      expect(response.body).to include(clothing.name)
    end
  end

  context "新規作成ページ表示" do
    it "新規作成ページへのリクエストが200OKであること" do
      get new_clothing_path
      expect(response.status).to eq 200
    end
  end

  context "服の登録" do
    it "正しいパラメーターで登録されること" do
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
      redirect_to clothings_path
      expect(response.status).to eq 302
    end
  end

  context "服の詳細ページ表示" do
    it "詳細ページへのリクエストが200OKであること" do
      get edit_clothing_path(clothing.id)
      expect(response.status).to eq 200
    end
  end

  context "服の登録情報の更新" do
    it "正しいパラメーターで更新されること" do
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

  context "服の削除処理" do
    it "服を削除できること" do
      expect {
        delete clothing_path(clothing.id)
      }.to change(Clothing, :count).by(-1)
    end
  end
end
