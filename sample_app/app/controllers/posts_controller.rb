class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :load_post, except: :create
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build post_params
    @comment = Comment.new
    if @post.save
      flash[:success] = t ".micropost_created"
      redirect_to root_url
    else
      @feed_items = current_user.posts.order_desc
        .paginate page: params[:page], per_page: Settings.per_page
      render "static_pages/home"
    end
  end

  def show
    @comment = @post.comments.build
    @comments = @post.comments.order_asc
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".has_error"
    end
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :pictures, :pictures_cache
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @post.user
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    render file: "public/404.html", status: :not_found
  end
end
