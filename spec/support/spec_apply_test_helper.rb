module SpecApplyTestHelper
  include Rack::Test::Methods

  def apply
    AppliesService.new
  end

  def new_apply(params)
    apply.create(params[:job_id], params[:user_id])
  end

end