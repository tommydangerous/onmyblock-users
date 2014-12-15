class Api::V1::UsersController < Api::V1::BaseController
  # def destroy
  #   User.find(params[:id]).destroy
  #   head 204
  # end

  # def show
  #   render json: User.find(params[:id]), status: 200
  # end

  def update
    response = nil
    status   = nil
    proc = Proc.new do |key|
      update_service = UpdateService.new User, params[:id], update_params
      update_service.process
      response = update_service.response
      status   = update_service.status
    end
    service = AuthenticateService.new params, proc
    service.process
    unless service.response
      response = service.response
      status   = service.status
    end
    render json: response, status: status
  end

  private

  def create_service_new
    UserCredentialService.new record_params
  end

  def record_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def update_params
    params.require(:user).permit(:email, :first_name, :last_name, :roles)
  end
end
