class ChangeUsernameAndPasswordNotNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :username, false
    change_column_null :users, :password_digest, false
    change_column :users, :username, :string, null: false
    change_column :users, :password_digest, :string, null: false
  end
end
