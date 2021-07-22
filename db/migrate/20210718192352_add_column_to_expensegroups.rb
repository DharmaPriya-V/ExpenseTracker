class AddColumnToExpensegroups < ActiveRecord::Migration[6.1]
  def change
    add_column :expensegroups, :group_status, :integer, default: 0
  end
end
