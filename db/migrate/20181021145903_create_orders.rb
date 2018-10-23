class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status
      t.string :phone
      t.string :address
      t.float :total
      t.references :account, foreign_key: true

      t.timestamps
    end
    add_index :orders, [:account_id, :created_at]
  end
end
