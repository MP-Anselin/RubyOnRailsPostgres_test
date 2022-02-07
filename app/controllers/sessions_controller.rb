class SessionsController < ApplicationController
  def signup
    if current_user
      render json: { status: "error", code: 409, message: "user already signed up" }
    else
      @User = User.new(session_params)
      @User.password = session_params[:password]

      if @User.save
        return render json: { user_id: @User.id, email: @User.email }
      end
      render json: { status: "error", code: 401, message: "invalid credentials" }
    end
  end

  def login
    @User = current_user
    if @User && @User.password == session_params[:password]
      token = encode_user_data({ user_data: @User.id })
      render json: { token: token }
    else
      render json: { status: "error", code: 401, message: "invalid credentials" }
    end
  end

  private

  def current_user
    User.find_by(email: session_params[:email]) if session_params[:email].present?
  end

  # Only allow a list of trusted parameters through.
  def session_params
    params_info = params.require(:session).permit(:email, :password)
    if params_info.empty? or
      !params_info.include?(:password) or
      !params_info.include?(:email)
      return render json: { status: "error", code: 401, message: "invalid credentials" }
    end
    params_info
  end
end