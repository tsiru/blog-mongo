module Admin
  class PostsController < BaseController
    load_and_authorize_resource :post
    add_breadcrumb 'wpisy', :admin_posts_path

    def index
    end

    def new
    end

    def create
    end

    def update
    end

    def destroy
    end

  end
end
