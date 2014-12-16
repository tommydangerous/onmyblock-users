class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate, only: [:update]

  def update
    render_envelope update_envelope
  end

  private

  def create_service_new
    UserCredentialService.new record_params
  end

  def record_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def update_envelope
    errors   = nil
    resource = nil
    if update_service.process
      resource = update_service.response
      status   = 200
    else
      errors = update_service.response
      status = 422
    end
    { errors: errors, resource: resource, status: status }
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
