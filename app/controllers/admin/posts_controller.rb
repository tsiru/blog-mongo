module Admin
  class PostsController < BaseController
    load_and_authorize_resource :post
    add_breadcrumb 'posts', :admin_posts_path

    def index
      respond_with @posts
    end

    def new
      respond_with @post
    end

    def create
    end

    def edit
      respond_with @post
    end

    def update
    end

    def destroy
    end

  end
end
