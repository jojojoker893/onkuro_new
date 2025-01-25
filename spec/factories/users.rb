FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "hoge+#{n}@example.com" }
    password { 'sample_password' }
  end
end
