class Api::V1::AuthenticationsController < Api::V1::BaseController
  def logout
    render json: logout_service.response, status: logout_service.status
  end

  private
  
  def create_service_new
    AuthenticationService.new record_params
  end

  def logout_service
    unless @logout_service
      @logout_service = LogoutService.new params
      @logout_service.process
    end
    @logout_service
  end

  def record_params
    params.require(:authentication).permit(:identification, :password)
  end
end
