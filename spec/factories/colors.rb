FactoryBot.define do
  factory :color do
    sequence(:name) { |n| "カラー#{n}" }

    trait :black do
      name { "黒" }
    end

    trait :white do
      name { "白" }
    end
  end
end
