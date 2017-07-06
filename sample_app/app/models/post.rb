class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :order_desc, ->{order created_at: :desc}
  scope :feed_by_following, lambda{|user_id, following_ids|
    where("user_id = ? OR user_id IN (?)", user_id, following_ids).order_desc}

  mount_uploader :pictures, PicturesUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.length_max}
  validates :title, presence: true,
    length: {maximum: Settings.micropost.title_max}
  validate :picture_size

  private

  def picture_size
    errors.add :pictures, I18n.t("too_big_file") if
      pictures.size > Settings.image_upload.max_size.megabytes
  end
end
