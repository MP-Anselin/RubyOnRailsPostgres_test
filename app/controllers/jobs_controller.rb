class JobsController < ApplicationController
  before_action :authentication
  before_action :set_job, only: %i[ show update applied destroy ]

  ##
  # initialize the job service from JobsService class which will execute the requests of JobsController
  #

  def initialize
    @job_service = JobsService.new
  end

  ##
  # Function to analyze the request get all job
  #
  # GET /jobs

  def index
    render json: @job_service.jobs_with_full_salary
  end

  ##
  # Function to analyze the request show job content
  #
  # params id:string id of the job to display
  #
  # GET /jobs/:id


  def show
    render json: @job_service.job
  end

  ##
  # Function to analyze the request create job
  #
  # params languages:array languages spoken of the job
  # params dates:array[many array] date beginning and end up of shift days
  # params title:string title of the job
  # params salary:integer salary of the job
  #
  # POST /jobs

  def create
    languages = params[:languages]
    dates = params[:dates]
    if languages.length < 0 or dates.length < 0 or dates.length > 7
      render json: { status: "error", st: 400, message: "bad parameters" }, status: 400
    elsif @job_service.create(job_params, languages, dates, current_user.id)
      render json: @job_service.job, status: :created, location: @job_service.job
    else
      render json: @job_service.job.errors, status: :unprocessable_entity
    end
  end

  ##
  # Function to analyze the request create job
  #
  # params id:string id of the job to update
  # params languages:array spoken languages of the job
  # params dates:array[many array] dates contents the date beginning and end up of shift days as array
  # params title:string title of the job
  # params salary:integer salary of the job
  #
  # PATCH/PUT /jobs/1

  def update
    params.require("id")
    if @job_service.update(job_params)
      render json: @job_service.job
    else
      render json: @job_service.job.errors, status: :unprocessable_entity
    end
  end

  ##
  # Function to analyze the request delete job
  #
  # params id:string id of the job to delete
  #
  # DELETE /jobs/1

  def destroy
    @job_service.destroy
  end

  ##
  # Function to analyze the request get jobs by title
  #
  # params title:string title of the jobs to find
  #
  # GET /jobs/title/:title

  def get_by_title
    params.require("title")
    render json: @job_service.get_by_title(job_params[:title]) if job_params[:title].present?
  end

  ##
  # Function to analyze the request get jobs by spoken language
  #
  # params languages:array languages spoken of the jobs
  #
  # GET /jobs/language/:language

  def get_by_language
    params.require("language")
    render json: @job_service.get_by_language(params[:language]) if params[:language].present?
  end

  private

  ##
  # Function to set the current job
  #
  # Use callbacks to share common setup or constraints between actions.

  def set_job
    @job_service.job = job_params[:id]
  end

  ##
  # Function to analyse the params
  #
  # permit id:string id of the job to update
  # permit languages:array spoken languages of the job
  # permit dates:array[many array] dates contents the date beginning and end up of shift days as array
  # permit title:string title of the job
  # permit salary:integer salary of the job
  #
  # Only allow a list of trusted parameters through.

  def job_params
    params.require("job").permit(:title, :salary, :languages, :dates, :id)
  end
end
