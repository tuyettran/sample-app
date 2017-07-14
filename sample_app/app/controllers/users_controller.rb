class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin!, only: :destroy

  def index
    @users = User.sort.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".please_check_mail"
      redirect_back_or root_url
    else
      flash.now[:warning] = t ".has_error"
      render :new
    end
  end

  def show
    @posts = @user.posts.order_desc
      .paginate page: params[:page], per_page: Settings.per_page
    @relationship = Relationship.new
    @comment = current_user.comments.build
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      flash.now[:warning] = t ".update_has_error"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:warning] = t ".delete_warning"
    end
    redirect_to users_path
  end

  def following
    @title = t ".following"
    @users = @user.following
      .paginate page: params[:page], per_page: Settings.per_page
    render "show_follow"
  end

  def followers
    @title = t ".follower"
    @user= User.find_by id: params[:id]

    render file: "public/404.html" unless @user

    @users = @user.followers
      .paginate page: params[:page], per_page: Settings.per_page
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    render file: "public/404.html", status: :not_found
  end

  def correct_user
    return if @user.current_user? current_user
    flash[:warning] = t ".permission"
    redirect_to login_url
  end

  def verify_admin!
    return if current_user.is_admin?
    flash[:warning] = t ".is_not_admin"
    redirect_to login_url
  end
end
