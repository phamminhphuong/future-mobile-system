class Order < ApplicationRecord
  belongs_to :account
  has_many :order_details, dependent: :restrict_with_exception

  validates :status, presence: true
  validates :phone, length: {maximum: Settings.size.max_phone},
    presence: true
  validates :address, length: {maximum: Settings.size.max_address},
    presence: true
  scope :select_order, -> {select :id, :status, :phone, :address, :total,
    :account_id, "date(created_at) as short_created_at"}
  delegate :fullname, to: :account, prefix: true
end
