class AddFieldnameToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :approval, :integer, default: 0
  end
end
