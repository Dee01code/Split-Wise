class RenameColumnToExpense < ActiveRecord::Migration[7.1]
  def change
    rename_column :expenses, :type, :expense_type
  end
end
