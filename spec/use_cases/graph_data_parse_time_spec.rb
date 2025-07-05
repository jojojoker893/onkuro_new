require 'rails_helper'
RSpec.describe GraphDataParseTime, type: :model do
  context "正しい日付パラメータを渡した場合" do
    let(:date) { "2025-01-01" }
    it "Timeオブジェクトを返す" do
      result = GraphDataParseTime.new(date).call
      expect(result).to eq(Time.zone.parse("2025-01-01"))
    end
  end

  context "空文字列を渡した場合" do
    let(:date) { " " }
    it "nilが返ること" do
      result = GraphDataParseTime.new(date).call
      expect(result).to be_nil
    end
  end

  context "無効な日付パラメータを渡した場合" do
    let(:date) { "invalid-date" }
    it "nilを返す" do
      result = GraphDataParseTime.new(date).call
      expect(result).to be_nil
    end
  end

  context "Time.zone.parseが例外を返した場合" do
    it "nilを返す" do
      allow(Time.zone).to receive(:parse).and_raise(ArgumentError)
      result = GraphDataParseTime.new("2025-01-01").call
      expect(result).to be_nil
    end
  end
end
