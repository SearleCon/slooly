class ApplicationController < ActionController::Base
  respond_to :html, :js, :json
  protect_from_forgery

  before_action :authenticate_user!
end
