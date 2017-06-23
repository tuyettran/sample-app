class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings.user.max_length_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.min_length_password}
  has_secure_password

  def downcase_email
    email.downcase!
  end
end
