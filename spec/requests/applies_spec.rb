require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  include SpecApiHelper
  include SpecApplyTestHelper

  apply_params = {
    user_id: 9,
    job_id: 19
  }
  let(:params) { { job: apply_params } }
  let(:user) { create(:user) }
  # let(:job) { create(:job) }

  describe "POST jobs/applied" do
    it "returns http success" do
      new_apply({job_id: apply_params[:job_id], user_id: user.id})
    end
  end
end
