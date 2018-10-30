class Image < ApplicationRecord
  mount_uploader :image_link, ImageUploader
  belongs_to :product
  validates :image_link, presence: true
end
