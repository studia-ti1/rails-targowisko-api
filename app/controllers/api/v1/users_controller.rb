class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
