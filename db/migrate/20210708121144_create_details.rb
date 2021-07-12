class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.string :allowance
      t.date :date
      t.numeric :amount
      t.string :merchant
      t.numeric :invoiceno

      t.timestamps
    end
  end
end
