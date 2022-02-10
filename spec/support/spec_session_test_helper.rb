module SpecSessionTestHelper
  include Rack::Test::Methods

  def session
    SessionsService.new
  end

  def signup_as(user)
    session.signup(user[:email], user[:password])
  end

  def login_as(user)
    token = session.login(user[:email], user[:password])
    { 'Authorization': "Bearer #{token}" }
  end

end