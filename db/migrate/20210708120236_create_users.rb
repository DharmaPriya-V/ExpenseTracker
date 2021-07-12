class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :department
      t.numeric :phoneno
      t.string :gender
      t.boolean :admin

      t.timestamps
    end
  end
end
