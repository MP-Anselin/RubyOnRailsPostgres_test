class ApplicationController < ActionController::API
  SECRET = "yoursecretword"
  ALGORITHM = "HS256"

  def current_user
    @Current_user = Current.user
  end

  def authentication
    authentication = request.headers["Authorization"]
    decode_data = decode_user_data(authentication)

    unless decode_data && decode_data[0].include?("user_data")
      render json: { status: "error", code: 401, message: "Unauthorized" }
      return
    end

    user_id = decode_data[0]["user_data"]
    user = User.find(user_id)
    session[:user_id] = user.id
    Current.user = user

    if user
      true
    else
      render json: { message: "invalid credentials" }
    end
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, ALGORITHM
  end

  def decode_user_data(token)
    begin
      JWT.decode token, SECRET, true, { algorithm: ALGORITHM }
    rescue => e
      puts e
    end
  end
end