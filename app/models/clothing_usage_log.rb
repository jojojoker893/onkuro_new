class ClothingUsageLog < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :used_at, presence: true

  def self.usage_period(startdate, enddate)
    where(created_at: startdate.beginning_of_day..enddate.end_of_day)
    .group(:clothing_id)
    .count
  end
end
