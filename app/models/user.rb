class User < ApplicationRecord
  has_many :clothings, dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def update_password(current_password, new_params) # この引数どっからきてるん
    if authenticate(current_password) # authenticateはなに？？
      update(new_params)
    else
      errors.add(:current_password, "が正しくありません") # errors.addってなに
      false
    end
  end
end
