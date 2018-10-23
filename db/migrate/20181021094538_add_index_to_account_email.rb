class AddIndexToAccountEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :accounts, :email, unique: true
  end
end
