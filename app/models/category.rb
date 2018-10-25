class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.size.length_name_category}
  scope :select_category, -> {select :id, :name}
end
