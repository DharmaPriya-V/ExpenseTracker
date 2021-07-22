class PhonenoChangeColumnType < ActiveRecord::Migration[6.1]
  def PhonenoChangeColumnType
    change_column :users, :phoneno, :integer
  end
end
