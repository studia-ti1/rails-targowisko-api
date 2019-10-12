class SessionsController < Devise::SessionsController
  # respond_to :json
  respond_to :json
  # skip_before_action :verify_signed_out_user, only: :destroy
  # skip_before_action :verify_signed_out_user, only: :destroy
  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end



  # private
  #
  # def respond_to_on_destroy
  #   head :ok
  # end
end
