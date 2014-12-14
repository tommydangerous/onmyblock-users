class Api::V1::AuthenticationsController < Api::V1::BaseController
  def logout
    read     = read_service Key, { token: params[:token] }
    response = read.response
    status   = read.status
    if response
      delete   = delete_service Key, { id: response.id }
      response = delete.response
      status   = delete.status
    end
    render json: response, status: status
  end

  private
  
  def create_service_new
    AuthenticationService.new record_params
  end

  def record_params
    params.require(:authentication).permit(:identification, :password)
  end
end
