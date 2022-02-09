class SessionsController < ApplicationController
  include ActionController::Cookies

  ##
  # initialize the session service from SessionsService class which will execute the requests of SessionsController
  #

  def initialize
    @sessions_service = SessionsService.new
  end

  ##
  # Function to analyze the request sign up user
  #
  # params email:string email of user
  # params password:string password of user
  #
  # GET /signup

  def signup
    case @sessions_service.signup(session_params[:email], session_params[:password])
    when 200
      render json: { user_id: @sessions_service.user_session.id, email: @sessions_service.user_session.email }
    when 409
      render json: { status: "error", code: 409, message: "user already signed up" }, status: 409
    else
      render json: { status: "error", code: 401, message: "invalid credentials" }, status: 401
    end
  end

  ##
  # Function to analyze the request login user and set Authorization token in cookies
  #
  # params email:string email of user
  # params password:string password of user
  #
  # GET /login

  def login
    if @sessions_service.login(session_params[:email], session_params[:password])
      cookies[:Authorization] = {
        value: @sessions_service.token,
        expires: 1.hour.from_now
      }
      user = @sessions_service.user_session
      render json: { id: user[:id], email: user[:email] }
    else
      render json: { status: "error", code: 401, message: "invalid credentials" }, status: 401
    end
  end

  ##
  # Function to analyze the request logout user and delete Authorization in the cookies
  #
  # permit email:string email of user
  # permit password:string password of user
  #
  # GET /logout

  def logout
    cookies[:Authorization] = {
      value: 0,
      expires: 0.1.second.from_now
    }
  end

  private

  ##
  # Function to analyse the params
  #
  # permit email:string email of user
  # permit password:string password of user
  #
  # Only allow a list of trusted parameters through.

  def session_params
    params.require("email")
    params.require("password")
    params_info = params.require("session").permit(:email, :password)
    if params_info.empty? or
      !params_info.include?(:password) or
      !params_info.include?(:email)
      return render json: { status: "error", code: 401, message: "invalid credentials" }, status: 401
    end
    params_info
  end
end
