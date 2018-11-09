class Image < ApplicationRecord
  mount_uploader :image_link, ImageUploader
  belongs_to :product
  validates :image_link, presence: true
  scope :select_image, -> {select :id, :image_link}
  scope :select_image_product, -> (id){where product_id: id}
end
