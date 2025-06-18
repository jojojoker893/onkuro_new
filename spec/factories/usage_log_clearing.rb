FactoryBot.define do
  factory :usage_log_clearing do
    user
    clothing
    reduced_at { Time.current }
  end
end
