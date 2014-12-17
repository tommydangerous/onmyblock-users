class Api::V1::AuthenticationsController < Api::V1::BaseController
  before_action :authenticate, only: :logout
  
  def login
    render_envelope login_envelope
  end

  def logout
    render_envelope logout_envelope
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

  def logout_envelope
    if logout_service.process
      errors   = nil
      resource = logout_service.response
      status   = 204
    else
      errors   = logout_service.response
      resource = nil
      status   = 404
    end
    { errors: errors, resource: resource, status: status }
  end

  def logout_service
    @logout_service ||= LogoutService.new params
  end
end
