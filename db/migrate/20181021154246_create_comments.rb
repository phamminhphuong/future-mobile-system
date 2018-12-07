class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :evaluate
      t.references :account, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:account_id, :created_at]
    add_index :comments, [:product_id, :created_at]
  end
end
