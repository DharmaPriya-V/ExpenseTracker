class AddSystemCheckStatusToDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :details, :system_check_status, :boolean, default: false
  end
end
