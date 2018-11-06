class Category < ApplicationRecord
  extend OpenSpreadsheet

  has_many :products, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.size.length_name_category}
  scope :select_category, -> {select :id, :name}
  scope :create_desc, -> {order created_at: :desc}

  private

  class << self
    def import file
      import_file file, ["name"]
    end
  end
end
