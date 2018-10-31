class CreateOrderDertails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.float :price
      t.float :total_price
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :order_details, [:order_id, :created_at]
    add_index :order_details, [:product_id, :created_at]
  end
end
