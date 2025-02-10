require 'rails_helper'

RSpec.describe User do
  describe "ユーザモデルテスト" do
    it "有効なuserの場合保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
    
    it "nameがなければ無効" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "emailがなければ無効" do 
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email])
    end
  end
end