class RemoveStatusFromExpensegroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :expensegroups, :status, :string
  end
end
