class ClothingUsageLog < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :used_at, presence: true

  scope :usage_period, ->(user_id, start_date, end_date) {
    joins(:clothing)
    .where(clothings: { user_id: user_id })
    .where(used_at: start_date.beginning_of_day..end_date.end_of_day)
    .group("clothings.id", "clothings.name")
    .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
  }
end
