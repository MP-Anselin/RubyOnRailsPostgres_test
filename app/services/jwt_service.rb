class JwtService
  SECRET = "yoursecretword"
  ALGORITHM = "HS256"

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
