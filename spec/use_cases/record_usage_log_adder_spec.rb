require 'rails_helper'

RSpec.describe RecordUsageLogAdder, type: :model do
let(:user) { create(:user) }
let!(:clothing1) { FactoryBot.create(:clothing, user: user, name: '白シャツ') }
let!(:clothing2) { FactoryBot.create(:clothing, user: user, name: '黒シャツ') }

context "使用回数を記録した時" do
  it "used_logが追加される" do
    aggregate_failures do
      expect { RecordUsageLogAdder.new(user: user, clothing_id: clothing1.id).call }
      .to change { ClothingUsageLog.count }.by(1)

      log = ClothingUsageLog.last
      expect(log.user).to eq(user)
      expect(log.clothing).to eq(clothing1)
      end
    end
  end
end
