class CreateJoinTableUsersExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :users_expenses, id: false do |t|
      t.belongs_to :user
      t.belongs_to :expense 
    end
  end
end
