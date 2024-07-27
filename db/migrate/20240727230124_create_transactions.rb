class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :sender
      t.integer :receiver
      t.float :amount
      t.timestamps
    end
  end
end
 