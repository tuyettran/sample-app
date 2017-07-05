class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.length_max}
  validate :picture_size

  private

  def picture_size
    errors.add :picture, I18n.t("too_big_file") if
      picture.size > Settings.micropost.image_max_size.megabytes
  end
end
