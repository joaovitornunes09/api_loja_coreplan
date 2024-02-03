class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.integer :discount_percentage
      t.references :product, null: true, foreign_key: true

      t.timestamps
    end
  end
end
