class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]

    render file: "public/404.html" unless @user

    if current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
    else
      flash[:warning] = t ".has_error"
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed

    render file: "public/404.html" unless user

    if current_user.unfollow user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
    else
      flash[:warning] = t ".has_error"
      redirect_to request.referrer || root_url
    end
  end
end
