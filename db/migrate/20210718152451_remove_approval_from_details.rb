class RemoveApprovalFromDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :details, :approval, :string
  end
end
