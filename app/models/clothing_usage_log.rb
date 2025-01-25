class ClothingUsageLog < ApplicationRecord
  belongs_to :cloth
  belongs_to :user

  validates :used_at, presence: true
end
