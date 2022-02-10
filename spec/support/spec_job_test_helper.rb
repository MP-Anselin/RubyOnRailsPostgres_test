module SpecJobTestHelper
  include Rack::Test::Methods

  def job
    JobsService.new
  end

  def all_job
    job.jobs
  end

  def one_job_by_id(id)
    job.job = id
  end

  def new_job(params)
    job_params = {
      title: params[:title],
      salary: params[:salary],
    }
    job.create(job_params, params[:spoken_languages], params[:shift_dates], params[:user_id])
  end

  def get_by_language(language)
    job.get_by_language(language)
  end

  def get_by_title(title)
    job.get_by_title(title)
  end

  def update(job_params)
    job.update(job_params)
  end

end