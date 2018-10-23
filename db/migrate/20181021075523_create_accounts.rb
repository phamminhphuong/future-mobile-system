class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.string :fullname
      t.string :address
      t.string :phone
      t.string :image

      t.timestamps
    end
  end
end
