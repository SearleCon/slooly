class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    respond_to do |format|
      format.html { render action: request.path[1..-1] }
      format.json { render json: { status: request.path[1..-1], error: @exception.message } }
    end
  end

  private

  def set_exception
    @exception = env['action_dispatch.exception']
  end
end
