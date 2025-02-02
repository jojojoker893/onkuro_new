class ClothingUsageLog < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :used_at, presence: true
end
