class Account < ApplicationRecord
  before_save {email.downcase!}
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
  scope :select_account, -> {select(:id, :fullname, :address, :phone, :email, :account_type)}
  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
