class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    return if current_user.present?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end
end
