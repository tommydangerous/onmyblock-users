class Api::V1::AuthenticationsController < Api::V1::BaseController
  before_action :authenticate, only: :logout

  def login
    render_envelope package_envelope(login_service, 200, 401)
  end

  def logout
    render_envelope package_envelope(logout_service, 204, 404)
  end

  private

  def login_service
    @login_service ||= LoginService.new params, KeySerializer
  end

  def logout_service
    service "delete", Key, { id: current_session.key.id }, nil
  end
end
