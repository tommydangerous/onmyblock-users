class Api::V1::BaseController < ApiController
  private

  def authenticate
    deny_access unless current_session.signed_in? && !current_session.expired?
  end

  def authorization
    request.headers["Authorization"]
  end

  def current_session
    @current_session ||= Session.new authorization
  end

  def delete_service(model, options, serializer = nil)
    service "delete", model, options, serializer
  end

  def deny_access
    render_envelope(
      errors:   deny_access_errors,
      resource: nil,
      status:   401
    )
  end

  def deny_access_errors
    if !current_session.signed_in?
      { access_denied: "you must login" }
    else
      { session_expired: "your session has expired" }
    end
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
