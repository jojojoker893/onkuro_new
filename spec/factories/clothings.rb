FactoryBot.define do
  factory :clothing do
    name { "白シャツ" }
    association :user
    association :category
    association :brand
    association :color
  end
end
