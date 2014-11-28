class ApplicationController < ActionController::Base
  include UnobtrusiveFlash

  respond_to :html, :js, :json
  protect_from_forgery

  before_action :authenticate_user!
end
