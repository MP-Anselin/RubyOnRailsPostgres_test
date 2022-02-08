class SessionsController < ApplicationController
  def initialize
    @sessions_service = SessionsService.new
  end

  def signup
    case @sessions_service.signup(session_params[:email], session_params[:password])
    when 200
      render json: { user_id: @sessions_service.user_session.id, email: @sessions_service.user_session.email }
    when 409
      render json: { status: "error", code: 409, message: "user already signed up" }
    else
      render json: { status: "error", code: 401, message: "invalid credentials" }
    end
  end

  def login
    if @sessions_service.login(session_params[:email], session_params[:password])
      render json: { token: @sessions_service.token }
    else
      render json: { status: "error", code: 401, message: "invalid credentials" }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def session_params
    params_info = params.require("session").permit(:email, :password)
    if params_info.empty? or
      !params_info.include?(:password) or
      !params_info.include?(:email)
      return render json: { status: "error", code: 401, message: "invalid credentials" }
    end
    params_info
  end
end
