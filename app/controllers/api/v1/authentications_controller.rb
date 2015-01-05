class Api::V1::AuthenticationsController < Api::V1::BaseController
  include Resourceful

  before_action :authenticate,         only: :logout
  before_action :set_key_id_parameter, only: :logout
  before_action :build_record

  def login
    render_resource :save do
      resource.status = :created
    end
  end

  def logout
    render_resource :destroy
  end

  private

  def set_key_id_parameter
    params[:authentication] = { key_id: current_session.key.id }
  end
end
