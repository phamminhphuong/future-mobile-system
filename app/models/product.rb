class Product < ApplicationRecord
  belongs_to :category
  belongs_to :manufacturer
  validates :name, presence: true, length: {maximum: Settings.size.length_name}
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true
  validates :description, presence: true,
    length: {maximum: Settings.size.length_name_description}
  validates :hot, presence: true, numericality: true
end
