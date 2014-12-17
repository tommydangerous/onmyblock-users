class Api::V1::AuthenticationsController < Api::V1::BaseController
  def login
    render_envelope login_envelope
  end

  def logout
    render json: logout_service.response
  end

  private

  def login_envelope
    if login_service.process
      errors   = nil
      resource = login_service.response
      status   = 200
    else
      errors   = login_service.response
      resource = nil
      status   = 401
    end
    { errors: errors, resource: resource, status: status }
  end

  def login_service
    @login_service ||= LoginService.new params, KeySerializer
  end

  def logout_service
    unless @logout_service
      @logout_service = LogoutService.new params
      @logout_service.process
    end
    @logout_service
  end
end
