class StaticPagesController < ApplicationController
  before_action :valid_page?

  def show
    if valid_page?
      if logged_in?
        @post = current_user.posts.build
        @feed_items = Post.feed_by_following(
          current_user.id, current_user.following.ids)
          .paginate page: params[:page], per_page: Settings.per_page
        @comment = current_user.comments.build
      end
      render template: "static_pages/#{params[:pages]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/static_pages/#{params[:pages]}.html.erb"
  end
end
