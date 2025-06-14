class UsageLogClearings < ApplicationRecord
  belongs_to :clothing
  belongs_to :user

  validates :reduced_at, presence: true
end
