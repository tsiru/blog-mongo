module Admin
  class BaseController < ApplicationController
    self.responder = ::AppResponder
    add_breadcrumb 'panel administracyjny', :admin_root_path
  end
end
