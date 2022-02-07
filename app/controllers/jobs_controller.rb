class JobsController < ApplicationController
  before_action :authentication
  before_action :set_job, only: %i[ show update destroy ]

  # GET /jobs
  def index
    @jobs = Job.all

    render json: @jobs
  end

  # GET /jobs/:id
  def show
    render json: @job
  end

  # GET /jobs/title/:email
  def get_by_title
    puts "HEllo"
    render json: Job.filter_by_title(params[:title])  if params[:title].present?
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :salary, :spoken_languages, :shift_dates)
    end
end
