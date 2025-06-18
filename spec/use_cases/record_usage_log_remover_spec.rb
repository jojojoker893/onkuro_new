require 'rails_helper'

RSpec.describe RecordUsageLogRemover, type: :model do
let(:user) { create(:user) }
let!(:clothing) { FactoryBot.create(:clothing, user: user, name: '白シャツ') }

context "使用ログがある時" do
  let!(:usage_log) { create(:clothing_usage_log, user: user, clothing: clothing) }
  it "usage_log_clearingのレコードが追加されること" do
    expect { RecordUsageLogRemover.new(user: user, clothing_id: clothing.id).call }
    .to change { UsageLogClearing.count }.by(1)
    end
  end

  context "使用ログが存在しない場合" do
    it "falseが返ること" do
      result =  RecordUsageLogRemover.new(user: user, clothing_id: clothing.id).call
      expect(result).to eq false
    end
  end

  context "減少ログが使用ログより多くなった時" do
    let!(:usage_log) { create(:clothing_usage_log, user: user, clothing: clothing) }
    let!(:clearing_log) { create(:usage_log_clearing, user: user, clothing: clothing) }
    it "falseが返ること" do
      result =  RecordUsageLogRemover.new(user: user, clothing_id: clothing.id).call
      expect(result).to eq false
    end
  end
end
