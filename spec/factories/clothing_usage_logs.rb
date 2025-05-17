FactoryBot.define do
  factory :clothing_usgae_logs do
    user
    clothing
    used_at { Time.current }
  end
end
