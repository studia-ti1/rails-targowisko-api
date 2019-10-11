class ExhibitionsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def index
    render json: Exhibition.all
  end
end
