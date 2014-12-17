class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate, only: [:update]

  def create
    render_envelope create_envelope
  end

  def update
    render_envelope update_envelope
  end

  private

  def create_envelope
    if create_service.process
      errors   = nil
      resource = create_service.response
      status   = 200
    else
      errors   = create_service.response
      resource = nil
      status   = 422
    end
    { errors: errors, resource: resource, status: status }
  end

  def create_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def create_service
    @create_service ||= UserCredentialService.new create_params, KeySerializer
  end

  def update_envelope
    if update_service.process
      errors   = nil
      resource = update_service.response
      status   = 200
    else
      errors   = update_service.response
      resource = nil
      status   = 422
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
