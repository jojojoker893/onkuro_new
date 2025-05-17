FactoryBot.define do
  factory :clothing_usage_log do
    user
    clothing
    used_at { Time.current }
  end
end
