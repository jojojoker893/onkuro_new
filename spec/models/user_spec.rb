require 'rails_helper'

RSpec.describe User do
  describe "ユーザモデルテスト" do
    it "有効なuserの場合保存されるか" do
      expect(build(:user)).to be_valid
    end

    it "nameがなければ無効" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Nameを入力してください")
    end

    it "emailがなければ無効" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Emailを入力してください")
    end

    it "passwordがなければ無効" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Passwordを入力してください")
    end

    it "passwordの長さが6文字未満なら無効" do
      user = build(:user, password: "12345")
      user.valid?
      expect(user.errors.full_messages).to include("Passwordは6文字以上で入力してください")
    end

    context "emailのバリデーションチェック" do
      let!(:test_user) { create(:user, email: "hoge@example.com") }

      it "重複したemailなら無効" do
        user = build(:user, email: test_user.email)
        user.valid?
        expect(user.errors.full_messages).to include("Emailはすでに存在します")
      end
    end
  end
end
