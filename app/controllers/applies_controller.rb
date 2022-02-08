class AppliesController < ApplicationController

  def initialize
    @applies_service = AppliesService.new
  end

  # POST /applied/:user_id/:job_id
  def create
    case @applies_service.create(applied_params[:job_id], applied_params[:user_id])
    when 409
      render json: { status: "error", code: 409, message: "user already applied for this job" }
    when 200
      render json: @applies_service.apply, status: :created
    else
      render json: @applies_service.apply.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def applied_params
    params.require("apply").permit(:job_id, :user_id)
  end
end
