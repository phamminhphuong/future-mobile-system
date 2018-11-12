class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: %i(google_oauth2)
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NUMBER_REGEX = /\d[0-9]\)*\z/
  enum account_type: %i(member admin)
  validates :fullname, presence: true, length: {maximum: Settings.size.max_fullname}
  validates :email, presence: true, length: {maximum: Settings.size.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.size.min_password}, allow_nil: true

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |account|
      account.email = auth.info.email
      account.password = Devise.friendly_token[0,20]
      account.password_confirmation = Devise.friendly_token[0,20]
      account.fullname = auth.info.name
    end
  end
end
