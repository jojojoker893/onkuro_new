require 'rails_helper'

RSpec.describe ClothingReport, type: :model do
  let(:user) { create(:user) }
  let!(:clothing1) { FactoryBot.create(:clothing, user: user, name: '白シャツ') }
  let!(:clothing2) { FactoryBot.create(:clothing, user: user, name: '黒シャツ') }

  context "キーワードを入力した場合" do
    it "絞り込めること" do
      result = ClothingReport.new(user_id: user.id, params: { keyword: '白' }).call

      expect(result).to include(clothing1)
      expect(result).not_to include(clothing2)
    end
  end
end
