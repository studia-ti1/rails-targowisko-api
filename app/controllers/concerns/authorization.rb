# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern
  include DeviseOverrideMethod

  included do
    respond_to :json # needed by devise
    before_action :authenticate_user
    before_action :configure_permitted_parameters, if: :devise_controller?

    private

    # params for registration for devise
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email])
    end

    # custom method for authenticating using jwt
    def authenticate_user
      return if request.headers['Authorization'].blank?

      jwt_payload = JwtHelper.decode(token: request.headers['Authorization'].split(' ').second)

      raise JWT::VerificationError if JwtBlacklist.any? { |obj| obj.jti == jwt_payload['jti'] }

      @current_user_id = jwt_payload['id']
    end
  end
end
