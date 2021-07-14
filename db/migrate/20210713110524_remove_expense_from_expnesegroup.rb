class RemoveExpenseFromExpnesegroup < ActiveRecord::Migration[6.1]
  def change
    remove_column :expensegroups, :expensegroupname, :string
  end
end
