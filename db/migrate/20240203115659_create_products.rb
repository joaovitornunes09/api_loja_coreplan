class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name,  null: false, unique: true
      t.text :description
      t.float :price, null: false, default: 0

      t.timestamps
    end
  end
end
