class Api::V1::CredentialsController < Api::V1::BaseController
  include Resourceful

  before_action :authorization_from_params
  before_action :authenticate
  before_action :set_confirmed_at

  def update
    render_resource :update_attributes, resource.attributes
  end

  private

  def authorization_from_params
    request.headers[authorization_header_key] = params[:token]
  end

  def set_confirmed_at
    params[:credential] = { confirmed_at: Time.zone.now }
  end
end
