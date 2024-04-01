class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
