class Api::V1::UsersApplicationController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  # def default_serializer_options
  #   { root: false }
  # end
end
