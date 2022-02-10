module SpecApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def authenticated_header(user) @jwt_service = JwtService.new

    puts "Authenticated header user => ", user.inspect

    token = @jwt_service.encode_user_data( { user_data: user.id })
    { 'Authorization': "Bearer #{token}" }
  end
end