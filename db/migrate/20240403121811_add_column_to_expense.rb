class AddColumnToExpense < ActiveRecord::Migration[7.1]
  def change
    add_column :expenses, :paid_by, :integer
  end
end
