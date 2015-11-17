class Admins::JobsController < Admins::BaseController

  before_action :set_job, except: :index

  def index
    @failed = Delayed::Job.all.where.not(last_error: nil)
    @pending = Delayed::Job.all.where(attempts: 0, locked_at: nil)
    @working = Delayed::Job.all.where.not(locked_at: nil)
  end

  def queue
    @job.update(last_error: nil, failed_at: nil, locked_at: nil, locked_by: nil, attempts: 0, run_at: Time.current)
    respond_with(:admins, @job, location: admins_jobs_url)
  end

  def destroy
    @job.destroy
    respond_with(:admins, @job, location: admins_jobs_url)
  end

  private
  def set_job
    @job = Delayed::Job.find(params[:id])
  end
end
