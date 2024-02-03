class CreateProductDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :product_discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.float :discount_value

      t.timestamps
    end
  end
end
