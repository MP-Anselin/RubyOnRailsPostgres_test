class AppliesService < ApplicationService

  ##
  # initialize the job service from JobsService class which will execute job requests for ApplicationService.
  # initialize the user service from UsersService class which will execute user requests for ApplicationService.
  #

  def initialize
    @jobs_service = JobsService.new
    @users_service = UsersService.new
  end

  ##
  # Function to get current Apply element

  def apply
    @Apply
  end

  ##
  # Function to get Apply model class functions

  def model
    Apply
  end

  ##
  # Function to create a new apply
  #
  # params job_id:string id of the job to applied
  # params user_id:integer id of the user which will apply

  def create(job_id, user_id)
    job = @jobs_service.model.find_by(id: job_id)
    user = @users_service.model.find_by(id: user_id)

    if !job_id or !user or Apply.find_by(user_id: user.id, job_id: job.id)
      return 409
    end

    @Apply = Apply.new(user: user, job: job)
    @Apply.save
    200
  end
end