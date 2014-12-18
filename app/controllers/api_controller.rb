class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  private

  def delete_service(model, options, serializer = nil)
    service "delete", model, options, serializer
  end

  def package_envelope(service, success_status, failure_status)
    if service.process
      errors   = nil
      resource = service.response
      status   = success_status
    else
      errors   = service.response
      resource = nil
      status   = failure_status
    end
    { errors: errors, resource: resource, status: status }
  end

  def render_envelope(opts)
    render json: Envelope.new(opts)
  end

  def service(action, model, options, serializer)
    name = "#{action}_service"
    ivar = "@#{name}"
    if instance_variable_get(ivar).nil?
      instance_variable_set ivar,
                            Object.const_get(name.camelize).new(
                              model, options, serializer
                            )
      instance_variable_get(ivar).process if instance_variable_get(ivar)
    end
    instance_variable_get ivar
  end
end
