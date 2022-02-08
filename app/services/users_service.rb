class UsersService < ApplicationService

  def get_by_email(email)
    User.find_by(email: email)
  end

  def get_by_id(id)
    User.find_by(id: id)
  end

  def current_user
    @Current_user
  end

  def update_jobs(user_id, job)
    user = get_by_id(user_id)
    user.update(jobs: [job])
  end
end