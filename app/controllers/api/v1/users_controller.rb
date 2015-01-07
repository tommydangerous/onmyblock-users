class Api::V1::UsersController < Api::V1::BaseController
  include Resourceful

  before_action :authenticate, only: :update

  skip_before_action :build_record, only: :create

  def create
    render_envelope package_envelope(create_service, 200, 422)
  end

  def update
    render_resource :update_attributes, resource.attributes
  end

  private

  def create_params
    params[:user] = params
    params.require(:user).permit :email, :first_name, :last_name, :password
  end

  def create_service
    @create_service ||= UserCredentialService.new create_params, KeySerializer
  end
end
