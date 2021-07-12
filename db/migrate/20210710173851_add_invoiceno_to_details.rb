class AddInvoicenoToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :invoiceno, :integer
  end
end
