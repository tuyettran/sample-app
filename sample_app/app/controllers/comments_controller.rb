class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_comment, except: :create
  before_action :commentable, only: [:create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build comment_params

    if @comment.save
      @post = @comment.post

      respond_to do |format|
        format.html{redirect_to request.referrer || root_url}
        format.js{render :layout =>false}
      end
    else
      @feed_items = current_user.posts.order_desc
        .paginate page: params[:page], per_page: Settings.per_page
      render "static_pages/home"
    end
  end

  def edit
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @post = @comment.post
    if @comment.destroy
      respond_to do |format|
        format.html{redirect_to request.referrer || root_url}
        format.json{head :no_content}
        format.js{render :layout => false}
      end
    else
      flash[:danger] = t ".has_error"
      redirect_to request.referrer || root_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit :post_id, :content
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    render file: "public/404.html"
  end

  def correct_user
    return if current_user.current_user? @comment.user
    flash[:danger] = t ".has_error"
    redirect_to request.referrer || root_url
  end

  def commentable
    @post = Post.find_by id: params[:comment][:post_id]

    render file: "public/404.html" unless @post

    return if current_user.following?(@post.user_id) || current_user = @post.user

    flash[:danger] = t "comments.cant_comment"
    redirect_to request.referrer || root_url
  end
end
