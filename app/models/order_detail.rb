class OrderDetail < ApplicationRecord
  belongs_to :order
  validates :quantity, length: {maximum: Settings.client.maximum4},
    presence: true
  validates :price, presence: true
end
