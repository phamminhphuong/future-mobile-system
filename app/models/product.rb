class Product < ApplicationRecord
  belongs_to :category
  belongs_to :manufacturer
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.size.length_name}
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true
  validates :description, presence: true,
    length: {maximum: Settings.size.length_name_description}
  validates :hot, presence: true, numericality: true
  scope :show_product, ->(id){where category_id: id}
  scope :select_manufacturer, -> {select :id, :name}
  scope :select_category, -> {select :id, :name}
  scope :select_product, -> {select :id, :name, :quantity, :price, :description,
    :hot, :category_id, :manufacturer_id}
  scope :show_detail, -> (id){where id: id}
  scope :select_products, -> {select :id, :name, :quantity, :price,
    :description, :hot, :category_id, :manufacturer_id}
end
