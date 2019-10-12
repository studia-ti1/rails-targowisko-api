class Api::V1::ExhibitionsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Exhibition.all
  end
end
