class ApplicationController < ActionController::API
  def current_user
   Current.user
  end

  def authentication
    @sessions_service = SessionsService.new
    user = @sessions_service.authentication_session(request.headers["Authorization"])
    unless user
      return render json: { status: "error", code: 401, message: "Unauthorized" }
    end
    session[:user_id] = user.id
    Current.user = user
    true
  end
end