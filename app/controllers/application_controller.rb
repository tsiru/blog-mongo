class ApplicationController < ActionController::Base
  respond_to :html
  protect_from_forgery
  layout 'admin'

  add_breadcrumb 'homepage', :root_path
end
