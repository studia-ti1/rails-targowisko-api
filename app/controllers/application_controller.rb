class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  before_action :authenticate_user, exclude: :destroy

  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  # DELETE /api/users/logout
  def logout
    # possible solution with cron job
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').second, 'secret').first
    jti = jwt_payload['jti']
    JwtBlacklist.create!(jti: jti)
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    render status: :no_content
  end

  private

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys:  %i[email])
  # end

  def authenticate_user
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').second, 'secret').first
        head :unauthorized if JwtBlacklist.any? { |obj|  obj.jti == jwt_payload['jti'] }
        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
  end
  end
end
