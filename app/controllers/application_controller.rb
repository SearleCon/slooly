class ApplicationController < ActionController::Base
  respond_to :html, :js, :json
  protect_from_forgery

  before_action :authenticate_user!

  etag { current_user.try :id }

  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def routing_error
    fail ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render 'pages/not_found'
  end
end
