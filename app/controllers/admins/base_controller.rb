class Admins::BaseController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  layout 'admin'

  before_action :authenticate_admin!
end
