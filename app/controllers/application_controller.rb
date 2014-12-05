class ApplicationController < ActionController::Base
  include UnobtrusiveFlash
  include LayoutRequired

  respond_to :html, :js, :json
  protect_from_forgery

  before_action :authenticate_user!
end
