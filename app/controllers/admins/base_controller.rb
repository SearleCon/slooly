module Admins
  class BaseController < ActionController::Base
    self.responder = ApplicationResponder
    respond_to :html, :js, :json

    layout 'admins/application'

    before_action :authenticate_admin!
  end
end
