class JobsService < ApplicationService

  ##
  # initialize the user service from UsersService which will execute user requests for JobsController.
  #

  def initialize
    @users_service = UsersService.new
  end

  ##
  # Function to get job model class functions

  def model
    Job
  end

  ##
  # Function to get job by id
  #
  # params id:string id of the job to find


  def job=(id)
    @job = Job.find(id)
  end

  ##
  # Function to get current Job element

  def job
    @job
  end

  ##
  # Function to execute request, get all the Jobs

  def jobs
    @jobs = Job.all
  end

  ##
  # Function to execute request, get all the Jobs

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

  ##
  # Function to execute request, creat job
  #
  # params spoken_languages:array spoken languages of the job
  # params shift_dates:array[many array] date beginning and end up of shift days
  # params user_id:integer id of the user of create je job
  #
  # params job_params:hash with:
  #                        title:string title of the job
  #                        salary:integer salary of the job

  def create(job_params, spoken_languages, shift_dates, user_id)
    @job = Job.new(job_params)
    @job.update(spoken_languages: spoken_languages, shift_dates: shift_dates)
    @job.user_id = user_id
    @users_service.update_jobs(@job.user_id, @job)
    @job.save
  end


  ##
  # Function to execute request, update job
  #
  # params job_params:hash with:
  #                        id:string id of the job to update
  #                        languages:array spoken languages of the job
  #                        dates:array[many array] dates contents the date beginning and end up of shift days as array
  #                        title:string title of the job
  #                        salary:integer salary of the job

  def update(job_params)
    @job.update(job_params)
  end

  ##
  # Function to execute request, delete current job

  def destroy
    @job.destroy
  end

  ##
  # Function to execute request, find job by title
  #
  # params title:string title of the job to find

  def get_by_title(title)
    Job.filter_by_title(title)
  end

  ##
  # Function to execute request, find job by language
  #
  # params language:string language of the job to find

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