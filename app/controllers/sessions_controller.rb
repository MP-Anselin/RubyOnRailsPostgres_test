class SessionsController < ApplicationController
  def signup
    user = User.new(email: params[:email], password: params[:password])

    if user.save
      token = encode_user_data({ user_id: user.id })
      render json: { token: token }
    else
      render json: { message: "invalid credentials" }
    end
  end

  def login
    puts "I PASS"
    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]
      token = encode_user_data({ user_data: user.id })
      render json: { token: token }
    else
      render json: {  status: "error", code: 401, message: "invalid credentials" }
    end
  end
end