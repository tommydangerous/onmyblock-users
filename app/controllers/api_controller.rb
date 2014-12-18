class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  private

  def render_envelope(opts)
    render json: Envelope.new(opts)
  end
end
