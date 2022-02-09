class SessionsService < ApplicationService

  ##
  # initialize the user service from UsersService class which will execute the requests of SessionsController
  # initialize the jwt service from JwtService class which will execute the requests of SessionsController
  #

  def initialize
    @users_service = UsersService.new
    @jwt_service = JwtService.new
    @token = nil
  end

  ##
  #Funtion to get user service intense


  def users_service
    @users_service
  end

  ##
  #Funtion to get jwt service intense

  def jwt_service
    @jwt_service
  end

  ##
  #Funtion to get the user token

  def token
    @token
  end

  def user_session(email = nil)
    if email
      @user = @users_service.get_by_email(email)
    end
    @user
  end

  ##
  # Function to authorize the user from token
  #
  # params authentication:string token authentication


  def authentication_session(authentication)
    decode_data = @jwt_service.decode_user_data(authentication)

    unless decode_data && decode_data[0].include?("user_data")
      return
    end

    user_id = decode_data[0]["user_data"]
    @users_service.model.find(user_id)
  end

  ##
  # Function to execute request, signup
  #
  # params email:string email of user
  # params password:string password of user
  #

  def signup(email, password)
    if @users_service.model.find_by(email: email)
      return 409
    end
    @user = @users_service.model.new(email: email, password: password)
    @user.password = password
    @user.save
    200
  end

  ##
  # Function to execute request, login
  #
  # params email:string email of user
  # params password:string password of user
  #

  def login(email, password)
    @user = user_session(email)
    if @user && @user.password == password
      @token = @jwt_service.encode_user_data({ user_data: @user.id })
    end
    @token
  end
end