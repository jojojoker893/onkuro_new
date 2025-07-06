FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "カテゴリー#{n}" }

    trait :tops do
      name { "トップス" }
    end

    trait :pants do
      name { "パンツ" }
    end
  end
end
