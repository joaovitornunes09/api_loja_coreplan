class Order < ApplicationRecord
  belongs_to :user
  has_many :order_discounts
  has_many :order_items
end
