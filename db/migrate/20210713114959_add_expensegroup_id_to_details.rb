class AddExpensegroupIdToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :expensegroup_id, :integer
  end
end
