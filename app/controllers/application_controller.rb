class ApplicationController < ActionController::Base
  respond_to :html
  protect_from_forgery
  add_breadcrumb 'homepage', :root_path

  before_filter :load_categories
  before_filter :load_authors

  private

  def load_categories
    @categories = Category.ordered.all
  end

  def load_authors
    @authors = User.authors.all
  end
end
