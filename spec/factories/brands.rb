FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "ブランド#{n}" }

    trait :uniqlo do
      name { "UNIQLO" }
    end

    trait :zara do
      name { "ZARA" }
    end
  end
end
