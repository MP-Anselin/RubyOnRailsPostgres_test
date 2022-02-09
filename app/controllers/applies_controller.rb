##
# This class manage the request when a user applied for a job.

class AppliesController < ApplicationController

  ##
  # initialize the apply service from AppliesService class which will execute the requests of AppliesController
  #

  def initialize
    @applies_service = AppliesService.new
  end

  ##
  # Function to analyze the request create user
  #
  # params job_id:string id of the job to applied
  # params user_id:string id of the user which will apply
  #
  # POST /applied

  def create
    case @applies_service.create(applied_params[:job_id], applied_params[:user_id])
    when 409
      render json: { status: "error", code: 409, message: "user already applied for this job" }, status: 409
    when 200
      render json: @applies_service.apply, status: :created
    else
      render json: @applies_service.apply.errors, status: :unprocessable_entity
    end
  end

  private

  ##
  # Function to analyse the params
  #
  # permit job_id:string id of the job to applied
  # permit user_id:string id of the user which will apply
  #
  # Only allow a list of trusted parameters through.

  def applied_params
    params.require("apply").permit(:job_id, :user_id)
  end
end
