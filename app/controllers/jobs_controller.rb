class JobsController < ApplicationController
  before_action :authentication
  before_action :set_job, only: %i[ show update applied destroy ]

  def initialize
    @job_service = JobsService.new
  end

  # GET /jobs
  def index
    render json: @job_service.jobs
  end

  # GET /jobs/:id
  def show
    render json: @job_service.job
  end

  # POST /jobs
  def create
    if @job_service.create(job_params, params[:languages], params[:dates], current_user.id)
      render json: @job_service.job, status: :created, location: @job_service.job
    else
      render json: @job_service.job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job_service.update(job_params)
      render json: @job_service.job
    else
      render json: @job_service.job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job_service.destroy
  end

  # GET /jobs/title/:title
  def get_by_title
    params.require("title")
    render json: @job_service.get_by_title(params[:title])  if params[:title].present?
  end

  # GET /jobs/language/:language
  def get_by_language
    params.require("language")
    render json: @job_service.get_by_language(params[:language])  if params[:language].present?
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job_service.job = params[:id]
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require("job").permit(:title, :salary, :languages, :dates)
    end
end
