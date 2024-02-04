class CreateResumeOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :resume_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.float :total_value
      t.float :total_value_with_discounts

      t.timestamps
    end
  end
end
