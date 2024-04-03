class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :password_Confirmation, :string
  end
end
