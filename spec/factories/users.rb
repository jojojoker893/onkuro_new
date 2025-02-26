FactoryBot.define do
  factory :user do
    name { "テストユーザ" }
    sequence(:email) { |n| "hoge#{n}@example.com" }
    password { 'sample_password' }
  end
end
