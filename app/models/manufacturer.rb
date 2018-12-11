class Manufacturer < ApplicationRecord
  acts_as_paranoid
  extend OpenSpreadsheet

  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.size.length_name}
  scope :select_manufacturer, -> {select :id, :name}

  private

  class << self
    def import file
      import_file file, ["name"]
    end
  end
end
