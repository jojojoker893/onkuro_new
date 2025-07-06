FactoryBot.define do
  factory :clothing do
    sequence(:name) { |n| "服#{n}" }
    association :user
    association :category
    association :brand
    association :color

    trait :white_shirt do
      name { "白シャツ" }
      association :category, :tops
      association :brand, :uniqlo
      association :color, :white
    end

    trait :black_pants do
      name { "黒パンツ" }
      association :category, :pants
      association :brand, :zara
      association :color, :black
    end
  end
end
