require 'rails_helper'

RSpec.describe "Clothings", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:brand) { create(:brand) }
  let!(:color) { create(:color) }
  let!(:clothing) { create(:clothing, user: user, category: category, brand: brand, color: color) }

  context "ログインしている場合" do
    before do
      post "/login", params: {
        session: {
          email: user.email,
          password: "sample_password"
        }
      }
    end

    it "一覧ページへのリクエストが200OKであること" do
      get clothings_path
      expect(response.status).to eq 200
    end

    it "自分の服のみ表示されること" do
      get clothings_path
      expect(response.body).to include(clothing.name)
    end
  end
end
