class Micropost < ApplicationRecord
  belongs_to :user

  scope :order_desc, ->{order created_at: :desc}
  scope :feed_by_following, lambda{|user_id, following_ids|
    where("user_id = ? OR user_id IN (?)", user_id, following_ids).order_desc}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.length_max}
  validate :picture_size

  private

  def picture_size
    errors.add :picture, I18n.t("too_big_file") if
      picture.size > Settings.image_upload.max_size.megabytes
  end
end
