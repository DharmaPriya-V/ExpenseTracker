class RemoveGrpStatusFromExpensegroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :expensegroups, :grp_status, :string
  end
end
