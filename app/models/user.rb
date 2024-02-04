class User < ApplicationRecord
  has_secure_password
  belongs_to :user_type
  has_many :orders
end
