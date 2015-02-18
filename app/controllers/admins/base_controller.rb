class Admins::BaseController < ActionController::Base
  include UnobtrusiveFlash
  include LayoutRequired

  respond_to :html, :js, :json


  layout 'admin'

  before_action :authenticate_admin!

end