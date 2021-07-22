class AddStatusToExpensegroups < ActiveRecord::Migration[6.1]
  def change
    add_column :expensegroups, :status, :integer, default: 0
  end
end
