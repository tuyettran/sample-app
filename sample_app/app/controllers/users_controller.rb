class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if find_user.nil?
      render file: "public/404.html", status: :not_found
    else
      @user = find_user
    end
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      flash.now[:warning] = t ".has_error"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    user = User.find_by id: params[:id]
    user.nil? ? nil : user
  end
end
