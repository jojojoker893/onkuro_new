require 'rails_helper'

RSpec.describe UsageLogClearing::CreateForm, type: :model do
  let(:user) { create(:user) }
  let(:clothing) { create(:clothing, user: user) }

  context '使用回数が減らせる場合' do
    before do
      create_list(:clothing_usage_log, 3, user: user, clothing: clothing)
      create(:usage_log_clearing, user: user, clothing: clothing)
    end

    it '減少ログが作成されること' do
      form = UsageLogClearing::CreateForm.new(clothing: clothing, user: user)

      aggregate_failures do
        expect { form.save }.to change(UsageLogClearing, :count).by(1)

        result = form.save
        expect(result.success?).to be true
        expect(result.error_message).to be_nil
      end
    end
  end

  context "使用回数が減らせない場合" do
    before do
      create_list(:clothing_usage_log, 2, user: user, clothing: clothing)
      create_list(:usage_log_clearing, 2, user: user, clothing: clothing)
    end

    it "UsageLogClearingが作成されないこと" do
      form = UsageLogClearing::CreateForm.new(clothing: clothing, user: user)

      aggregate_failures do
        expect { form.save }.not_to change(UsageLogClearing, :count)

        result = form.save
        expect(result.success?).to be false
        expect(result.error_message).to eq("使用回数をこれ以上減らせません")
      end
    end
  end

  context "使用回数と削除回数が同じ場合" do
    before do
      create(:clothing_usage_log, user: user, clothing: clothing)
      create(:usage_log_clearing, user: user, clothing: clothing)
    end

    it "使用回数を減らせないこと" do
      result = UsageLogClearing::CreateForm.new(clothing: clothing, user: user).save

      aggregate_failures do
        expect(result.success?).to be false
        expect(result.error_message).to eq("使用回数をこれ以上減らせません")
      end
    end
  end

  context 'UsageLogClearingの保存に失敗した場合' do
    before do
      create_list(:clothing_usage_log, 3, user: user, clothing: clothing)
      create(:usage_log_clearing, user: user, clothing: clothing)
    end

    it '失敗すること' do
      fake_log = instance_double(UsageLogClearing, save: false, errors: double(full_messages: [ "保存に失敗しました" ]))

      allow(UsageLogClearing).to receive(:new).and_return(fake_log)

      form = UsageLogClearing::CreateForm.new(clothing: clothing, user: user)
      result = form.save

      expect(result.success?).to be false
      expect(result.error_message).to eq "保存に失敗しました"
    end
  end
end
