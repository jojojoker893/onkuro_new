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
end
