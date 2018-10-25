class Account < ApplicationRecord
  before_save {email.downcase!}
  has_many :orders
  has_many :comments
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NUMBER_REGEX = /\d[0-9]\)*\z/
  enum account_type: %i(member admin)
  validates :fullname, presence: true, length: {maximum: Settings.client.maximum1}
  validates :address, presence: true
  validates :phone, presence: true,format: {with: NUMBER_REGEX,
    message: I18n.t("type_phone")}
  validates :email, presence: true, length: {maximum: Settings.client.maximum2},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.client.minimum}
  scope :select_account, -> {select(:id, :fullname, :address, :phone, :email, :account_type)}
  has_secure_password
end
