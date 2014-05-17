module Admin
  class BaseController < ApplicationController
    layout 'admin'
    self.responder = ::AppResponder
    add_breadcrumb 'administration', :admin_root_path
  end
end
