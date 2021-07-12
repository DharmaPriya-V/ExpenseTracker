class ChangeSomeName < ActiveRecord::Migration[6.1]
  def change
    rename_column :details, :type, :allowance
  end
end
