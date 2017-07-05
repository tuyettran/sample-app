class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
    only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_sent"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_not_found"
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t(".can_not_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attributes reset_digest: nil
      flash[:success] = t ".password_reseted"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]

    return if @user
    flash.now[:warning] = t ".not_found"
    render file: "public/404.html", status: :not_found
  end

  def valid_user
    return if @user && @user.is_activated? &&
      @user.authenticated?(:reset, params[:id])
    flash[:warning] = t ".not_valid_user"
    redirect_to root_url
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t ".password_reset_expired"
      redirect_to new_password_reset_url
    end
  end
end
