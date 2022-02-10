require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  include SpecApiHelper
  include SpecJobTestHelper

  job_params = {
    title: "test",
    salary: 300,
    languages: %w[fr es],
    dates: [%w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
            %w[01/01/2022 31/01/2022],
    ]
  }
  let(:params) { { job: job_params } }
  let(:user) { create(:user) }
  # let(:job) { create(:job) }


  describe "GET /jobs" do
    it "returns http success" do
      all_job
    end
  end

  describe "POST /jobs" do
    it "returns http success" do
      new_job(job_params)
    end
  end

  describe "GET /jobs/:id" do
    it "returns http success" do
      one_job_by_id(1)
    end
  end

  describe "PUT /jobs/:id" do
    it "returns http success" do
      update({ id: 1, title: "update title" })
    end
  end

  describe "GET /jobs/title/:title" do
    it "returns http success" do
      get_by_title(job_params[:title])
    end
  end

  describe "GET /jobs/languages/:language" do
    it "returns http success" do
      get "/jobs/languages/:language"
      get_by_language(job_params[:title[:"fr"]])
    end
  end

end
