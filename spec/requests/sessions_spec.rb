require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  include SpecSessionTestHelper

  session = { email: "anselin.mp@gmail.com",
              password: "mackendy"
  }
  let(:credentials) { { session: session } }

  describe "POST /signup cases" do
    it "returns http success" do
      signup_as(session)
    end
  end

  describe "POST /login" do
    it "returns http success" do
      login_as(session)
    end
  end

end
