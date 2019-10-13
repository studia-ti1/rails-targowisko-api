# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
