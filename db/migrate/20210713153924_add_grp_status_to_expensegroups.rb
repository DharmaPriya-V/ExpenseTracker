class AddGrpStatusToExpensegroups < ActiveRecord::Migration[6.1]
  def change
    add_column :expensegroups, :grp_status, :string
  end
end
