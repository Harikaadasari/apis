
class User < ApplicationRecord
  
  has_secure_password
  has_many :projects, dependent: :destroy
  validates :name, :mobile, :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, confirmation: true

end
