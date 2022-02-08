class SessionsController < ApplicationController
  include ActionController::Cookies
  
  def initialize
    @sessions_service = SessionsService.new
  end

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

  def logout
    cookies[:Authorization] = {
      value: 0,
      expires: 0.1.second.from_now
    }
  end

  private

  # Only allow a list of trusted parameters through.
  def session_params
    params_info = params.require("session").permit(:email, :password)
    if params_info.empty? or
      !params_info.include?(:password) or
      !params_info.include?(:email)
      return render json: { status: "error", code: 401, message: "invalid credentials" }, status: 401
    end
    params_info
  end
end
