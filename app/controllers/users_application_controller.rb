class UsersApplicationController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_resource, only: [:destroy, :show, :update]
  respond_to :json

  # POST /api/v1/{plural_resource_name}
  def create
    set_resource resource_class.new(resource_params)
    if get_resource.save
      render json: get_resource, status: :created
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  # GET /api/{plural_resource_name}/1
  def show
    respond_with get_resource
  end

  private

  # Returns the resource from the created instance variable
  # @return [Object]
  def get_resource
    instance_variable_get("@#{resource_name}")
  end

  # Returns the allowed parameters for searching
  # Override this method in each API controller
  # to permit additional parameters to search on
  # @return [Hash]
  def query_params
    {}
  end

  # Returns the allowed parameters for pagination
  # @return [Hash]
  def page_params
    params.permit(:page, :page_size)
  end

  # The resource class based on the controller
  # @return [Class]
  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  # The singular name for the resource class based on the controller
  # @return [String]
  def resource_name
    @resource_name ||= self.controller_name.singularize
  end

  # Only allow a trusted parameter "white list" through.
  # If a single resource is loaded for #create or #update,
  # then the controller for the resource must implement
  # the method "#{resource_name}_params" to limit permitted
  # parameters for the individual model.
  def resource_params
    @resource_params ||= self.send("#{resource_name}_params")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource(resource = nil)
    resource ||= resource_class.find(params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end

  def render_json(hash, status = :ok)
    hash = hash.as_json if hash.respond_to?(:as_json)
    render json: JSON.dump(hash), status: status
  end
end
