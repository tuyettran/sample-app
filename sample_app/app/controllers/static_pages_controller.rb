class StaticPagesController < ApplicationController
  before_action :valid_page?

  def show
    if valid_page?
      if logged_in?
        @micropost = current_user.microposts.build
        @feed_items =
          current_user.feed.order_desc.paginate(page: params[:page],per_page: 5)
      end
      render template: "static_pages/#{params[:pages]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist? Pathname.new(Rails.root +
      "app/views/static_pages/#{params[:pages]}.html.erb")
  end
end
