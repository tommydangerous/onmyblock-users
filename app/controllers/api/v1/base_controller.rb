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

  def create_service
    if @create_service.nil?
      @create_service = create_service_new
      @create_service.process if @create_service
    end
    @create_service
  end

  def create_service_new
    # Override this
  end

  def delete_service(model, options, serializer = nil)
    service "delete", model, options, serializer
  end

  def deny_access
    if !current_session.signed_in?
      errors = { access_denied: "you must login" }
    else
      errors = { session_expired: "your session has expired" }
    end
    render_envelope(
      errors:   errors,
      resource: nil,
      status:   401
    )
  end

  def read_service(model, options, serializer = nil)
    service "read", model, options, serializer
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
