require 'rails_helper'

RSpec.describe Clothing, type: :model do
  describe "検索機能" do
    let!(:match) { create(:clothing, name: "白シャツ") }
    let!(:no_match) { create(:clothing, name: "黒パンツ") }

    it "キーワードに部分一致しているnameを返す" do
      result = Clothing.search_keyword("シャツ")
      expect(result).to include(match)
      expect(result).not_to include(no_match)
    end
  end

  describe "カテゴリフィルター" do
    let(:category1) { create(:category, name: "トップス") }
    let(:category2) { create(:category, name: "ジャケット") }
    let!(:tops) { create(:clothing, category: category1) }
    let!(:jacket) { create(:clothing, category: category2) }

    it "指定したカテゴリを返す" do
      result = Clothing.filter_category(category1.id)
      expect(result).to include(tops)
      expect(result).not_to include(jacket)
    end
  end
end
