class SessionsService < ApplicationService
  def initialize
    @users_service = UsersService.new
    @jwt_service = JwtService.new
    @token = nil
  end

  def users_service
    @users_service
  end

  def jwt_service
    @jwt_service
  end

  def token
    @token
  end

  def user_session(email = nil)
    if email
      @user = @users_service.get_by_email(email)
    end
    @user
  end

  def authentication_session(authentication)
    decode_data = @jwt_service.decode_user_data(authentication)

    unless decode_data && decode_data[0].include?("user_data")
      return
    end

    user_id = decode_data[0]["user_data"]
    @users_service.model.find(user_id)
  end

  def signup(session_params)
    if @users_service.model.find_by(email: session_params[:email])
      return 409
    end
    @user = @users_service.model.new(session_params)
    @user.password = session_params[:password]
    @user.save
    200
  end

  def login(email, password)
    @user = user_session(email)
    if @user && @user.password == password
      @token = @jwt_service.encode_user_data({ user_data: @user.id })
    end
    @token
  end
end