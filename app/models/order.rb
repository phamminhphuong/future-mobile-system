class Order < ApplicationRecord
  belongs_to :account
  has_many :order_details
  validates :status, presence: true
  validates :phone, length: {maximum: Settings.client.maximum3},
    presence: true
  validates :address, length: {maximum: Settings.client.maximum2},
    presence: true
end
