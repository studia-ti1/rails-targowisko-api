# frozen_string_literal: true

module DeviseOverrideMethod
  extend ActiveSupport::Concern

  included do
    # UNIVERSITY overrides methods from devise gem
    def authenticate_user!(_options = {})
      head :unauthorized unless signed_in?
    end

    def current_user
      @current_user ||= super || User.find(@current_user_id)
    end

    def signed_in?
      @current_user_id.present?
    end
  end
end
