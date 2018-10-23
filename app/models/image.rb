class Image < ApplicationRecord
  belongs_to :product
  validates :name, presence: true, length: {maximum: Settings.size.length_name}
  validates :product_id, presence: true
end
