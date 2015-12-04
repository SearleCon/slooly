module Admins
  class JobsController < Admins::BaseController

    before_action :set_job, except: :index

    def index
      @failed =  Job.failed
      @pending = Job.pending
      @working = Job.working
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
      @job = Job.find(params[:id])
    end
  end
end
