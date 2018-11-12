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
    where "date(created_at) >= ? AND date(created_at) <= ?", start_date, end_date}
  scope :select_order_detail_by_order, -> (order_id){where order_id: order_id}
  delegate :id, :name, :price, to: :product, prefix: true

  private

  class << self
    def to_xls options = {}
      quantity = 0
      total_price = 0
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |order_detail|
          csv << order_detail.attributes.values_at(*column_names)
          quantity += order_detail.quantity
          total_price += order_detail.total_price
        end
        csv << []
        csv << ["SUM", quantity, "", total_price]
      end
    end
  end
end
