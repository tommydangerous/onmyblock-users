class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  private

  def instance_variable(name)
    "@#{service_name name}"
  end

  def new_object(name, args)
    Object.const_get(name).new(*args)
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
    render json: ResponseEnvelope.new(opts)
  end

  def service(action, model, options, serializer, record_id = nil)
    if instance_variable_get(instance_variable(action)).nil?
      if action == "update"
        args = [model, record_id, options, serializer]
      else
        args = [model, options, serializer]
      end
      obj = new_object service_name(action).camelize, args
      instance_variable_set instance_variable(action), obj
    end
    instance_variable_get instance_variable(action)
  end

  def service_name(name)
    "#{name}_service"
  end
end
