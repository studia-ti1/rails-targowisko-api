# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      # TODO: permitted params
      def create
        user = User.find_by(email: params[:user][:email])

        if user&.valid_password?(params[:user][:password])
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
    end
  end
end
