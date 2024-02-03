class Product < ApplicationRecord
    has_many :offers
    has_many :order_items
    has_many :product_discounts
end
