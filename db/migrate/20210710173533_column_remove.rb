class ColumnRemove < ActiveRecord::Migration[6.1]
  def up
    remove_column :details, :invoiceno
end
def down
  add_column :details, :invoiceno, :integer
end
end
