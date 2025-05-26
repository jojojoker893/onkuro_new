require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "正常にレスポンスを返すこと" do
      get :new
      expect(response).to be_successful
    end
  end
end
