class Product < ApplicationRecord
    has_many :order_items, dependent: :destroy
    has_many :offers, dependent: :destroy
    validate :name_not_equal_to_geral

    private
  
    def name_not_equal_to_geral
      errors.add(:name, "Geral é um nome reservado, use outro nome.") if name.downcase == 'geral'
    end
end
