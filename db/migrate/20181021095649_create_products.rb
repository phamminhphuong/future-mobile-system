class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.text :description
      t.integer :hot
      t.references :category, foreign_key: true
      t.references :manufacturer, foreign_key: true

      t.timestamps
    end
    add_index :products, [:category_id, :created_at]
    add_index :products, [:manufacturer_id, :created_at]
  end
end
