module Admin
  class CategoriesController < BaseController
    load_and_authorize_resource :category
    add_breadcrumb 'categories', :admin_categories_path
    before_filter :add_category_breadcrumb, except: :index

    def index
      @categories = @categories.page(params[:page])
      respond_with @categories
    end

    def new
      respond_with @category
    end

    def create
      @category.update_attributes(params[:category])
      if @category.valid?
        respond_with @category, location: request.referer
      else
        render :new
      end
    end

    def edit
      respond_with @category
    end

    def update
      @category.update_attributes(params[:category])
      if @category.valid?
        respond_with @category, location: request.referer
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      respond_with @user, location: request.referer
    end

    private

    def add_category_breadcrumb
      if @category.present?
        if @category.persisted?
          add_breadcrumb @category.humanize
        else
          add_breadcrumb 'new category'
        end
      end
    end

  end
end
