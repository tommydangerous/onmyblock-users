class Api::V1::AuthenticationsController < Api::V1::BaseController
  def login
    render json: login_service.response, status: login_service.status
  end

  def logout
    render json: logout_service.response, status: logout_service.status
  end

  private

  def login_service
    unless @login_service
      @login_service = LoginService.new params
      @login_service.process
    end
    @login_service
  end

  def logout_service
    unless @logout_service
      @logout_service = LogoutService.new params
      @logout_service.process
    end
    @logout_service
  end
end
