class AppliesService < ApplicationService

  def initialize
    @jobs_service = JobsService.new
    @users_service = UsersService.new
  end

  def apply
    @Apply
  end

  def model
    Apply
  end

  def create(job_id, user_id)
    job = @jobs_service.model.find_by(id: job_id)
    user = @users_service.model.find_by(id: user_id)

    if !job_id or !user.id or Apply.find_by(user_id: user.id, job_id: job.id)
      return 409
    end

    @Apply = Apply.new(user: user, job: job)
    @Apply.save
    200
  end
end