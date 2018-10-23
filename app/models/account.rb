class Account < ApplicationRecord
  before_save {email.downcase!}
  has_many :orders
  has_many :comments
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :fullname, presence: true, length: {maximum: Settings.client.maximum1}
  validates :address, presence: true
  validates :phone, presence: true
  validates :email, presence: true, length: {maximum: Settings.client.maximum2},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.client.minimum}
  has_secure_password
end
