class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
