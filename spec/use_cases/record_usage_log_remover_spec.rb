require 'rails_helper'

RSpec.describe RecordUsageLogRemover, type: :model do
let(:user) { create(:user) }
let!(:clothing1) { FactoryBot.create(:clothing, user: user, name: '白シャツ') }
let!(:clothing2) { FactoryBot.create(:clothing, user: user, name: '黒シャツ') }
let!(:log) { FactoryBot.create(:clothing_usage_log, user: user, clothing: clothing1) }

context "使用回数を減らした時" do
  it "used_logが削除される" do
    expect { RecordUsageLogRemover.new(user: user, clothing_id: clothing1.id).call }
    .to change { ClothingUsageLog.count }.by(-1)
    end
  end
end
