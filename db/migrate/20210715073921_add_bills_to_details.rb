class AddBillsToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :bills, :string
  end
end
