class AddDeleteAtToManufacturer < ActiveRecord::Migration[5.2]
  def change
    add_column :manufacturers, :deleted_at, :datetime
    add_index :manufacturers, :deleted_at
  end
end
