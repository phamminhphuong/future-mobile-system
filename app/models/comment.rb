class Comment < ApplicationRecord
  belongs_to :account
  belongs_to :product
  validates :content, presence: true
  scope :select_comment, -> {select :id, :content, :account_id, :product_id}
  scope :show_comment_desc, -> {order created_at: :desc}
end
