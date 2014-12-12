class Api::V1::AuthenticationsController < ApiController
  def create
    render json: create_service.response, status: create_service.status
  end

  private

  def authentication_params
    params.require(:authentication).permit(:identification, :password)
  end

  def create_service
    if @create_service.nil?
      @create_service = AuthenticationService.new authentication_params
      @create_service.process
    end
    @create_service
  end
end
