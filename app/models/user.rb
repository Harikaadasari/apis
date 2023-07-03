
class User < ApplicationRecord
  has_secure_password

  validates :name, :mobile, :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, confirmation: true

end
