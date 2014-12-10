class UsersApplicationController < ApplicationController
  respond_to :json

  private

  def render_json(hash, status = :ok)
    hash = hash.as_json if hash.respond_to?(:as_json)
    render json: JSON.dump(hash), status: status
  end
end
