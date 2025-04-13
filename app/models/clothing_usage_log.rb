class ClothingUsageLog < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :used_at, presence: true

  def self.usage_log(user:, clothing_id:) # 使用回数の記録
    clothing = user.clothings.find(clothing_id)
    create(user: user, clothing: clothing, used_at: Time.current)
  end

  scope :usage_period, ->(user_id, startdate, enddate) {
    joins(:clothing)
    .where(clothings: { user_id: user_id })
    .where(used_at: startdate.beginning_of_day..enddate.end_of_day)
    .group("clothings.id", "clothings.name")
    .pluck("clothings.name, COUNT(clothing_usage_logs.id)")
  }
end
