require 'rails_helper'

RSpec.describe ClothingReport, type: :model do
  let(:user) { create(:user) }
  let!(:clothing1) { FactoryBot.create(:clothing, user: user, name: '白シャツ') }
  let!(:clothing2) { FactoryBot.create(:clothing, user: user, name: '黒シャツ') }

  before do
    create_list(:clothing_usage_log, 2, user: user, clothing: clothing1)
    create(:clothing_usage_log, user: user, clothing: clothing2)
  end

  context "キーワードを入力した場合" do
    it "絞り込めること" do
      aggregate_failures do
        result = ClothingReport.new(user_id: user.id, params: { keyword: '白' }).call

        expect(result).to include(clothing1)
        expect(result).not_to include(clothing2)
      end
    end
  end

  context "usage_ascを指定した場合" do
    it "使用回数が少ない順に並ぶ" do
      aggregate_failures do
        result = ClothingReport.new(user_id: user.id, params: { order: "usage_asc" }).call

        expect(result.first).to eq(clothing2)
        expect(result.second).to eq(clothing1)
      end
    end
  end

  context "usage_descを指定した場合" do
    it "使用回数が多い順に並ぶ" do
      aggregate_failures do
        result = ClothingReport.new(user_id: user.id, params: { order: "usage_desc" }).call

        expect(result.first).to eq(clothing1)
        expect(result.second).to eq(clothing2)
      end
    end
  end

  context "orderパラメータが空の場合" do
    it "created_at順になる" do
      result = ClothingReport.new(user_id: user.id, params: {}).call

      expect(result.first.created_at).to be > result.second.created_at
    end
  end
end
