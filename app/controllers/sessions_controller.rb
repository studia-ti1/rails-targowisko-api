class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

   # DELETE /api/users/logout
   def destroy
    # possible solution with cron job
    begin
      jwt_payload = JwtHelper.decode(token: request.headers['Authorization'].split(' ').second)
      jti = jwt_payload['jti']
      JwtBlacklist.create!(jti: jti)
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :no_content
    end
  end
end
