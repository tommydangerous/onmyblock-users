class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate
  
  def update
    service   = authenticate_service update_callback
    @response = service.response unless service.response
    render json: @response
  end

  private

  def authenticate_service(callback)
    unless @authenticate_service
      @authenticate_service = AuthenticateService.new params, callback
      @authenticate_service.process
    end
    @authenticate_service
  end

  def create_service_new
    UserCredentialService.new record_params
  end

  def record_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def update_callback
    proc do |_key|
      @response = update_service.response
    end
  end

  def update_params
    params.require(:user).permit(:email, :first_name, :last_name, :roles)
  end

  def update_service
    unless @update_service
      @update_service = UpdateService.new User, params[:id], update_params
      @update_service.process
    end
    @update_service
  end
end
