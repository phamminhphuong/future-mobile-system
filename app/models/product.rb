class Product < ApplicationRecord
  extend OpenSpreadsheet

  belongs_to :category
  belongs_to :manufacturer
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.size.length_name}
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true
  validates :description, presence: true,
    length: {maximum: Settings.size.length_name_description}
  validates :hot, presence: true, numericality: true
  scope :show_product, -> (id){where category_id: id}
  scope :show_product_desc, -> {order created_at: :desc}
  scope :show_product_hot_desc, -> {order hot: :desc}
  scope :select_manufacturer, -> {select :id, :name}
  scope :select_category, -> {select :id, :name}
  scope :select_product, -> {select :id, :name, :quantity, :price, :description,
    :hot, :category_id, :manufacturer_id}
  scope :show_product_price, lambda {|price_begin, price_end|
    where "price >= ? AND price <= ?", price_begin, price_end}
  scope :show_detail, -> (id){where id: id}
  scope :select_products, -> {select :id, :name, :quantity, :price,
    :description, :hot, :category_id, :manufacturer_id}
  scope :show_image, -> (id){where product_id: id}
  delegate :name, to: :manufacturer, prefix: true
  delegate :name, to: :category, prefix: true

  private

  class << self
    def search(key)
      if key
        where("name LIKE ?", "%#{key}%").select_products.show_product_desc
      else
        select_products.show_product_desc
      end
    end

    def import file
      import_file file, ["name", "quantity", "price", "description", "hot", "category_id", "manufacturer_id"]
    end
  end
end
