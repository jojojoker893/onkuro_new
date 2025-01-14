class User < ApplicationRecord
  has_many :clothes, class_name: "Cloth", dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
