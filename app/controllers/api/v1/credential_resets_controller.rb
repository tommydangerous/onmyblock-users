class Api::V1::CredentialResetsController < Api::V1::BaseController
  include Resourceful

  def create
    render_resource :save do
      resource.status = 201
    end
  end
end
