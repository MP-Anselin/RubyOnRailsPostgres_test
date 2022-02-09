class UsersService < ApplicationService

  ##
  # Function to get User model class functions

  def model
    User
  end

  ##
  # Function to execute request, find user by email
  #
  # params email:string email of the user to find

  def get_by_email(email)
    User.find_by(email: email)
  end

  ##
  # Function to execute request, find user by id
  #
  # params id:string id of the user to find

  def get_by_id(id)
    User.find_by(id: id)
  end

  ##
  # Function to execute request, create job, we store which job the user created
  #
  # params user_id:string id of the user who creates the job
  # params job:Job job is a intense of the job is created
  #

  def update_jobs(user_id, job)
    user = get_by_id(user_id)
    user.jobs << job
  end
end