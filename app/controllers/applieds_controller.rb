class AppliedsController < ApplicationController
  # POST /applied/:user_id/:job_id
  def create
    job = Job.find_by(id: applied_params[:job_id])
    user = User.find_by(id: applied_params[:user_id])

    if Applied.find_by(user_id: user.id, job_id: job.id)
      return render json: { status: "error", code: 409, message: "user already applied for this job"}
    end

    @Applied = Applied.new(user: user, job: job)
    if @Applied.save
      render json: @Applied, status: :created
    else
      render json: @Applied.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def applied_params
    params.require(:applied).permit(:job_id, :user_id)
  end
end
