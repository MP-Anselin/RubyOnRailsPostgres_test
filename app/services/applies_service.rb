class AppliesService < ApplicationService

  def apply
    @Apply
  end

  def create(job_id, user_id)
    job = Job.find_by(id: job_id)
    user = User.find_by(id: user_id)

    if !job_id or !user.id or Apply.find_by(user_id: user.id, job_id: job.id)
      return 409
    end

    @Apply = Apply.new(user: user, job: job)
    @Apply.save
    200
  end
end