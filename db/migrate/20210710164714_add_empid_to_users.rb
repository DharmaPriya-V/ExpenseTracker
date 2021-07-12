class AddEmpidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :empid, :string
  end
end
