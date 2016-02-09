class ErrorsController < ActionController::Base
  before_action :send_error_notification, if: :internal_server_error?
  layout 'application'

  def show
    respond_to do |format|
      format.html { render action: status_code }
      format.json { render json: { status: status_code, error: exception.message } }
    end
  end

  private

  def exception
    env['action_dispatch.exception']
  end

  def status_code
    ActionDispatch::ExceptionWrapper.status_code_for_exception(exception.class.name)
  end

  def send_error_notification
    exception_name = exception.class.to_s
    message = exception.message
    backtrace = ActionDispatch::ExceptionWrapper.new(env, exception).application_trace.join("\n")
    ErrorNotifier.notify(exception_name, message, backtrace).deliver_now
  end

  def internal_server_error?
    status_code == Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error]
  end
end
