module Admin
  class PostsController < BaseController
    load_and_authorize_resource :post
    add_breadcrumb 'posts', :admin_posts_path
    before_filter :add_post_breadcrumb, except: :index

    def index
      respond_with @posts
    end

    def new
      respond_with @post
    end

    def create
      @post.update_attributes(params[:post].merge(author: current_user))
      if @post.valid?
        respond_with @post, location: request.referer
      else
        render :new
      end
    end

    def edit
      respond_with @post
    end

    def update
      @post.update_attributes(params[:post])
      if @post.valid?
        respond_with @post, location: request.referer
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      respond_with @user, location: request.referer
    end

    private

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
end
