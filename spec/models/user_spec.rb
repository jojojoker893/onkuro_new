require 'rails_helper'

RSpec.describe User do
  before(:each) do
    User.delete_all
  end

  describe "ユーザモデルテスト" do
    it "有効なuserの場合保存されるか" do
      expect(build(:user)).to be_valid
    end

    it "nameがなければ無効" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "emailがなければ無効" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "passwordがなければ無効" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "passwordの長さが6文字未満なら無効" do
      user = build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    let!(:test_user) { create(:user, email: "hoge@example.com") }

    it "重複したemailなら無効" do
      user = build(:user, email: test_user.email)
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
