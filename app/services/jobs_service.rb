class JobsService < ApplicationService

  def initialize
    @users_service = UsersService.new
  end

  def job=(id)
    @job = Job.find(id)
  end

  def job
    @job
  end

  def jobs
    @jobs = Job.all
  end

  # POST /jobs
  def create(job_params, spoken_languages, shift_dates, user_id)
    @job = Job.new(job_params)
    @job.update(spoken_languages: spoken_languages, shift_dates: shift_dates)
    @job.user_id = user_id
    @users_service.update_jobs(@job.user_id, @job)
    @job.save
  end

  def update(job_params)
    @job.update(job_params)
  end

  def destroy
    @job.destroy
  end

  def get_by_title(title)
    Job.filter_by_title(title)
  end
end