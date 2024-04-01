class RenameUsersExpensesToExpensesUsers < ActiveRecord::Migration[7.1]
  def change
    rename_table :users_expenses, :expenses_users
  end
end
