class CreateOrderDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_discounts do |t|
      t.references :order, null: false, foreign_key: true
      t.float :discount_value

      t.timestamps
    end
  end
end
