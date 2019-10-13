# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      # TODO: permitted params
      def create
        user = User.find_by(email: session_params[:email])

        if user&.valid_password?(session_params[:password])
          @current_user = user
        else
          render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
        end
      end

      # DELETE /api/users/logout
      def destroy
        # possible solution with cron job
        jwt_payload = JwtHelper.decode(token: request.headers['Authorization'].split(' ').second)
        jti = jwt_payload['jti']
        JwtBlacklist.create!(jti: jti)
      end

      private

      def session_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
