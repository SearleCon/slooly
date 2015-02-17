class Admin::JobsController < Admin::BaseController
  before_action :set_job, except: :index

  def index
    @all_jobs = jobs_scope
    @failed = jobs_scope.where.not(last_error: nil)
    @pending = jobs_scope.where(attempts: 0, locked_at: nil)
    @working = jobs_scope.where.not(locked_at: nil)
  end

  def queue
    flash[:notice]= t('flash.jobs.queue') if @job.update(last_error: nil, failed_at: nil, locked_at: nil, locked_by: nil, attempts: 0, run_at: Time.current)
    respond_with @job, location: admin_jobs_url
  end

  def destroy
    @job.destroy
    flash[:notice]= t('flash.jobs.destroy') if @job.destroyed?
    respond_with @job, location: admin_jobs_url
  end

  private
  def jobs_scope
    Delayed::Job.all
  end

  def set_job
   @job = jobs_scope.find(params[:id])
  end

end