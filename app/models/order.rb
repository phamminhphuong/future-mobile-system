class Order < ApplicationRecord
  belongs_to :account
  has_many :order_details, dependent: :destroy
  validates :status, presence: true
  validates :phone, length: {maximum: Settings.size.max_phone},
    presence: true
  validates :address, length: {maximum: Settings.size.max_address},
    presence: true
  scope :select_order, -> {select :id, :status, :phone, :address, :total,
    :account_id, :created_at}
  delegate :fullname, to: :account, prefix: true
end
