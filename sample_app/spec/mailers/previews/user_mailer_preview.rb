class UserMailerPreview < ActionMailer::Preview
  def account_activation
    user = User.last
    user.activation_token = User.new_token
    UserMailer.account_activation user
  end

  def password_reset
    user = User.last
    user.reset_token = User.new_token
    UserMailer.password_reset user
  end
end
