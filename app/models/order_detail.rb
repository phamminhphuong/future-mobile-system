class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :images, through: :product
  validates :quantity, length: {maximum: Settings.size.max_quantity},
    presence: true
  validates :price, presence: true
  scope :select_order_detail, -> {select :id, :quantity, :price, :total_price,
    :order_id, :product_id}
  scope :created_between, lambda {|start_date, end_date|
    where "created_at >= ? AND created_at <= ?", start_date, end_date}
  delegate :id, :name, :price, to: :product, prefix: true
end
