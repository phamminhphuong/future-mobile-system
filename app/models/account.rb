class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable
  has_many :orders
  has_many :comments, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NUMBER_REGEX = /\d[0-9]\)*\z/
  enum account_type: %i(member admin)
  validates :fullname, presence: true, length: {maximum: Settings.size.max_fullname}
  validates :address, presence: true
  validates :phone, presence: true,format: {with: NUMBER_REGEX,
    message: I18n.t("type_phone")}
  validates :email, presence: true, length: {maximum: Settings.size.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.size.min_password}, allow_nil: true
end
