class Changecolumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :expense_id, :detail_id
  end
end
