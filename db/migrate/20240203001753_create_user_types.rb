class CreateUserTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :user_types do |t|
      t.string :name_type

      t.timestamps
    end
  end
end
