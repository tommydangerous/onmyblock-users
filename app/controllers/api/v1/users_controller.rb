class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate, only: :update

  def create
    render_envelope package_envelope(create_service, 200, 422)
  end

  def update
    render_envelope package_envelope(update_service, 200, 422)
  end

  private

  def create_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def create_service
    @create_service ||= UserCredentialService.new create_params, KeySerializer
  end

  def update_params
    params.require(:user).permit(:email, :first_name, :last_name, :roles)
  end

  def update_service
    @update_service ||= UpdateService.new(
      User, params[:id], update_params, UserSerializer
    )
  end
end
