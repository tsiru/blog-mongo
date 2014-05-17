class PostsController < ApplicationController
  load_and_authorize_resource :post
  before_filter :add_post_breadcrumb,       except: :index
  before_filter :ensure_post_is_published!, except: :index
  before_filter :apply_user_filter,         only: :index
  before_filter :apply_category_filter,     only: :index
  before_filter :apply_tag_filter,          only: :index

  def index
    @posts = @posts.published.ordered.paginate(page: params[:page], per_page: 5)
    respond_with @posts
  end

  def show
    @comment = Comment.new
    respond_with @post
  end

  def comment
    @comment = @post.comments.create(params[:comment])
    if @comment.valid?
      flash[:success] = 'Post has been commented.'
      respond_with @comment, location: post_path
    else
      flash[:warning] = 'An error occured.'
      render :show
    end
  end

  private

  # filter by :author param
  def apply_user_filter
    return if params[:author].blank?
    User.find(params[:author]).tap do |user|
      @posts = @posts.where author: user
      add_breadcrumb "by author \"#{user.humanize}\""
    end
  end

  # filter by category param
  def apply_category_filter
    return if params[:category].blank?
    Category.find(params[:category]).tap do |category|
      @posts = @posts.where category: category
      add_breadcrumb "by category \"#{category.humanize}\""
    end
  end

  # filter by :tag param
  def apply_tag_filter
    return if params[:tag].blank?
    params[:tag].tap do |tag|
      @posts = @posts.tagged_with tag
      add_breadcrumb "by tag \"#{tag}\""
    end
  end


  def ensure_post_is_published!
    raise ActiveRecord::RecordNotFound unless @post.published?
  end

  def add_post_breadcrumb
    if @post.present?
      if @post.persisted?
        add_breadcrumb @post.humanize
      else
        add_breadcrumb 'new post'
      end
    end
  end
end
