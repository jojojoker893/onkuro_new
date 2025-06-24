require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /users/new" do
    context "ユーザー登録画面の表示をした時" do
      it "ユーザー登録画面へのリクエストが200OKであること" do
        get new_user_path
        expect(response).to have_http_status (:ok)
      end
    end
  end

  describe "POST /users" do
    context "正しいパラメータを送信した時" do
      it "ユーザーが作成されログインページへリダイレクトすること" do
        expect {
          post "/users", params: {
            user: {
              name: "test_user",
              email: "test@example.com",
              password: "valid_password",
              password_confirmation: "valid_password"
            }
          }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status (:found)
        expect(response).to redirect_to login_path
        follow_redirect!
        expect(response.body).to include ("登録しました")
      end
    end
  end

  context "不正なパラメータを送信した時" do
    it "ユーザー登録が失敗して新規登録画面が再表示されること" do
      expect {
        post "/users", params: {
          user: {
            name: "error_user",
            email: "miss_email",
            password: "valid_password",
            password_confirmation: nil
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status (:unprocessable_entity)
      expect(response.body).to include("登録に失敗しました")
      expect(response.body).to include("新規登録")
    end
  end

  describe "PATCH /user" do
    let(:user) { create(:user) }

    # ログイン状態の作成
    before do
      post "/login", params: {
        session: {
          email: user.email,
          password: "sample_password"
        }
      }
    end

    context "正しいパラメータを送信した時" do
      it "ユーザー情報が更新されること" do
        expect {
          patch "/user", params: {
            user: {
              name: "update_name",
              email: "update_email@example.com"
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status (:found)
        expect(user.reload.name).to eq("update_name")
        expect(response).to redirect_to user_path
        follow_redirect!
        expect(response.body).to include("更新しました")
      end
    end

    context "不正なパラメータを送信した時" do
      it "ユーザー情報が更新されず再度画面が表示されること" do
        expect {
          patch "/user", params: {
            user: {
              name: nil,
              email: "miss_email"
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status (:unprocessable_entity)
        expect(response.body).to include ("更新に失敗しました")
        expect(response.body).to include ("更新")
      end
    end
  end

  describe "PATCH user/password" do
    let(:user) { create(:user) }

    # ログイン状態の作成
    before do
      post "/login", params: {
        session: {
          email: user.email,
          password: "sample_password"
        }
      }
    end

    context "正しいパラメータを送信した時" do
      it "パスワードが更新されること" do
        patch "/user/password", params: {
          user: {
            current_password: "sample_password",
            password: "new_password",
            password_confirmation: "new_password"
          }
        }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to edit_password_user_path
        follow_redirect!
        expect(response.body).to include("パスワードを変更しました")
      end
    end
  end
end
