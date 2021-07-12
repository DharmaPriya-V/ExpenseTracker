class AddApprovalToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :approval, :string
  end
end
