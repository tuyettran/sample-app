class UsersController < ApplicationController
  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".welcome"
      log_in @user
      redirect_to @user
    else
      flash.now[:warning] = t ".has_error"
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return @user if @user.present?
    render file: "public/404.html", status: :not_found
  end
end
