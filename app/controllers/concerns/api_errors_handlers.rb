# frozen_string_literal: true

module ApiErrorsHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from JWT::VerificationError, with: :token_error
    rescue_from JWT::DecodeError, with: :token_error
    rescue_from JWT::ExpiredSignature, with: :token_error

    private

    def record_not_found(err)
      render json: { errors: [err.message] }, status: :not_found
    end

    def record_invalid(err)
      render json: err.record.errors.messages, status: :unprocessable_entity
    end

    def token_error
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end
end
