class Api::V1::CredentialsController < Api::V1::BaseController
  before_action :authorization_from_params
  before_action :authenticate

  def update
    render_envelope package_envelope(update_service, 200, 304)
  end

  private

  def authorization_from_params
    request.headers["Authorization"] = params[:token]
  end

  def update_service
    @update_service ||= UpdateService.new Credential,
                                          params[:id], confirmed_at: Time.zone.now
  end
end
