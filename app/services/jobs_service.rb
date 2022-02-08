class JobsService < ApplicationService

  def initialize
    @users_service = UsersService.new
  end

  def model
    Job
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

  def jobs_with_full_salary
    @jobs = jobs
    @jobs.each { |job|
      count = 0
      job.shift_dates.each { |dates|
        count += (dates[1].to_i - dates[0].to_i)
      }
      job.salary *= count
    }
    @jobs
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

  def get_by_language(language)
    result = []
    jobs.each do |job|
      if job.spoken_languages.include? language
        result << job
      end
    end
    result
  end
end