# frozen_string_literal: true

module Api
  module V1
    class ExhibitionsController < ApplicationController
      before_action :authenticate_user!

      def index
        render json: Exhibition.all
      end
    end
  end
end
