class ClothingUsageLog < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :used_at, presence: true

  scope :usage_period, ->(user_id, startdate, enddate) {
    joins(:clothing)
    .where(clothings: { user_id: user_id })
    .where(used_at: startdate.beginning_of_day..enddate.end_of_day)
    .group("clothings.id", "clothings.name")
    .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
  }
end
