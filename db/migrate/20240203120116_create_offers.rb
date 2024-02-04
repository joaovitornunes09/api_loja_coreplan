class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.integer :discount_percent
      t.references :product, null: true

      t.timestamps
    end
  end
end
