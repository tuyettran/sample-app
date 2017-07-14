class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true,
    length: {maximum: Settings.comment.length_max}
  validates :user_id, presence: true
  validates :post_id, presence: true

  scope :order_asc, -> {order(created_at: :asc)}
end
