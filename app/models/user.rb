class User < ApplicationRecord
  has_many :clothings, dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def update_password(current_password, new_params)
    if authenticate(current_password)
      update(new_params)
    else
      errors.add(:currnet_password, "が正しくありません")
      false
    end
  end
end
