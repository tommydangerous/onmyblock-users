class Api::V1::AuthenticationsController < Api::V1::BaseController

  private
  
  def new_create_service
    AuthenticationService.new record_params
  end

  def record_params
    params.require(:authentication).permit(:identification, :password)
  end
end
