class CreateExpensegroups < ActiveRecord::Migration[6.1]
  def change
    create_table :expensegroups do |t|
      t.integer :user_id
      t.decimal :totalamount
      t.decimal :approvedamount
      t.string :expensegroupname
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
