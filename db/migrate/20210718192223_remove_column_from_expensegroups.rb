class RemoveColumnFromExpensegroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :expensegroups, :group_status, :integer
  end
end
