require 'rails_helper'

RSpec.describe ClothingUsageGraph, type: :model do
  let(:user) { create(:user) }
  let!(:clothing1) { FactoryBot.create(:clothing, user: user, name: '白シャツ') }
  let!(:clothing2) { FactoryBot.create(:clothing, user: user, name: '黒シャツ') }
  let(:start_date) { 5.days.ago.to_date }
  let(:end_date) { Date.today }
  let!(:log1) { create(:clothing_usage_log, user: user, clothing: clothing1, used_at: 3.days.ago) }

  context "期間を指定した場合" do
    it "usage_periodのデータになること" do
      result = ClothingUsageGraph.new(user: user, start_date: start_date, end_date: end_date).call
      expect(result).to eq ([ { name: "白シャツ", y: 1 } ])
    end
  end

  context "期間が指定されていない場合" do
    before do
      create(:clothing_usage_log, user: user, clothing: clothing1)
      create(:clothing_usage_log, user: user, clothing: clothing2)
    end

    it "全体の使用回数が表示されること" do
      result = ClothingUsageGraph.new(user: user, start_date: nil, end_date: nil).call
      expect(result).to match_array([
        { name: "白シャツ", y: 2 },
        { name: "黒シャツ", y: 1 }
      ])
    end
  end
end
