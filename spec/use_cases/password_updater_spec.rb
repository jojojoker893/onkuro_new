require 'rails_helper'
RSpec.describe PasswordUpdater, type: :model do
  let(:user) { create(:user) }

  context "正しいパスワードが入力された時" do
    it "パスワードの更新に成功すること" do
      result = PasswordUpdater.new(user, user.password, { password: "new_password" }).call
      expect(result).to be true
      expect(user.authenticate("new_password")).to be_truthy
      expect(user.password).to eq("new_password")
    end
  end

  context "現在のパスワードが間違っている場合" do
    it "パスワードの更新に失敗すること" do
      result = PasswordUpdater.new(user, "miss_password", { password: "new_password" }).call
      expect(result).to be false
      expect(user.authenticate("sample_password")).to be_truthy
      expect(user.authenticate("new_password")).to be_falsey
    end
  end
end
